if (qGuardAppName === undefined) {
    throw new Error("Q-Guard: Q-Guard application name is not configured correctly in config.js!");
}

if (qGuardAppUrl === undefined) {
    throw new Error("Q-Guard: Q-Guard application domain is not configured correctly in config.js!");
}

if (qGuardApiUrl === undefined) {
    throw new Error("Q-Guard: Q-Guard API URL is not configured correctly in config.js!");
}

if(qGuardAppUrl !== window.location.origin)
{
    throw new Error("Q-Guard : Not on right domain");
}


/*******************************************************************************************************/
/*                                        GET SESSION ID                                               */
/*******************************************************************************************************/ 

let sessionId = null;
let isRequestingSession = false;
let intervalSessionId = setInterval(getSessionId, 500);
function getSessionId()
{
    if(!isRequestingSession)
    {
        isRequestingSession = true;

        let idStorage = sessionStorage.getItem('sessionId');
        if(idStorage)
        {
            sessionId = idStorage;
            clearInterval(intervalSessionId);
        }
        else
        {
            $jQGuard.ajax({
                type: "POST",
                async: true,
                contentType : 'text/plain',
                url: qGuardApiUrl + "/api/catch-event/new-session",
                data :  qGuardAppName,
                success : function(response){
                    sessionId = response.session_id;
                    sessionStorage.setItem('sessionId', sessionId);
                    clearInterval(intervalSessionId);
                    isRequestingSession = false;
                },
                error : function(result, status, error)
                {
                    isRequestingSession = false;
                }
            })
        }
    }
       
}

/*******************************************************************************************************/
/*                                      DATA SENDING  PART                                             */
/*******************************************************************************************************/ 
 
let num = 0;
let sequence = sessionStorage.getItem('sequence');
if(sequence)
{
    num = sequence;
}

//Make an eventJson object
function makeEventJson(urlS, eventS, options, dom, entityId)
{
  num ++;
  click = null;
  keypress = null;;

  var dateNow = new Date();

  var eventJson = 
  {
    appName : qGuardAppName,
    created_at : dateNow,
    url : urlS,
    options : JSON.stringify(options),
    event : eventS,
    sequence : num,
    dom : dom,
    entityId : entityId
  }
  return eventJson;
}

//POST request to the api
function post(urlS, eventS, options, dom_outer_html, entityId)
{
    //console.log(eventS);
    var eventJson = makeEventJson(urlS, eventS, options, dom_outer_html, entityId);
    console.log(eventJson);
    storeEventJson(eventJson);
}

//Store eventsJson into session Storage
function storeEventJson(eventJson)
{
    let eventsJson = sessionStorage.getItem('eventsJson');

    //Push into eventsJson array
    if(eventsJson)
    {
        eventsJson = JSON.parse(eventsJson);
        eventsJson.push(eventJson);
        
        eventsJson = JSON.stringify(eventsJson);
        sessionStorage.setItem('eventsJson', eventsJson)
        
    }
    //Create the array
    else
    {
        eventsJson = [eventJson];
        eventsJson = JSON.stringify(eventsJson);
        sessionStorage.setItem('eventsJson', eventsJson);
    }

    
    sessionStorage.setItem('sequence', num);
}

/***********************************************/
/*Functions to send events to the microservice */
/********************************************* */

let isAlreadySendingEvent = false;
sendOneStoredEvent();
setInterval(sendOneStoredEvent, 500);

function deleteFirstEventInSessionStorage()
{
    let events = sessionStorage.getItem('eventsJson');
    events = JSON.parse(events);
    events.splice(0,1);
    events = JSON.stringify(events);
    sessionStorage.setItem('eventsJson', events);
}

function sendOneStoredEvent()
{
    if(sessionId)
    {
        let events = sessionStorage.getItem('eventsJson');
        events = JSON.parse(events);
        if(events)
        {
            if(events.length > 0 && !isAlreadySendingEvent)
            {
                isAlreadySendingEvent = true;
                let zip = new JSZip();
                let urlPost = qGuardApiUrl + "/api/catch-event/add";

                let event = events[0];
                let dom_outer_html = event.dom;
                zip.file('dom.html', dom_outer_html);
                zip.generateAsync({type:"base64", compression:"DEFLATE"}).then(function(dom){
                    event.dom = dom;
                    event.sessionId = sessionId;
                    event = JSON.stringify(event);
                    $jQGuard.ajax({
                        type: "POST",
                        url: urlPost,
                        data: event,
                        contentType: "application/json; charset=utf-8",
                        xhrFields: {
                            withCredentials: true
                        },
                        success : function(html_code, status)
                        {
                            deleteFirstEventInSessionStorage();
                            isAlreadySendingEvent = false;
                        },
                        error : function(result, status, error)
                        {
                            if(result.status == 409)
                            {
                                deleteFirstEventInSessionStorage();
                            }
                            isAlreadySendingEvent = false;
                        }
                    });
                });          
            }
        }
    }
}


/******************************************************************************************************/
//                                      Get Xpath functions
/******************************************************************************************************/

function getElementXPath(elt)
{
     var path = "";
     for (; elt && elt.nodeType == 1; elt = elt.parentNode)
     {
   	idx = getElementIdx(elt);
	xname = elt.tagName;
	if (idx > 1) xname += "[" + idx + "]";
	path = "/" + xname + path;
     }
 
     return path;	
}
function getElementIdx(elt)
{
    var count = 1;
    for (var sib = elt.previousSibling; sib ; sib = sib.previousSibling)
    {
        if(sib.nodeType == 1 && sib.tagName == elt.tagName)	count++
    }
    
    return count;
}

/*******************************************************************************************************/
//                                      CHANGE ADD EVENT LISTENER
/*******************************************************************************************************/

var oldAddEventListener = EventTarget.prototype.addEventListener;

EventTarget.prototype.addEventListener =  function(eventName, eventHandler, entity, element, location, func)
{
     oldAddEventListener.call(this, eventName,  function(event){
        if(entity)
        {
            if(eventName === "click")
            {
                if((element === "input" && entity.type !== "text") || element !== "input")
                {   
                    clickEvent(entity, element, location);
                }
            }

            if(eventName === "focus")
            {
                focusEvent(entity, element, location);
            }

            if(eventName === "blur")
            {
                blurEvent(entity, element, location);
            }

            if(eventName === "change")
            {
                changeEvent(entity, element, location);
            }
        }

        if(func)
        {
            func();
        }
        
        eventHandler(event);
    })
}

/*******************************************************************************************************/
//                                       ADD EVENT LISTENERS TO DOM
/*******************************************************************************************************/

oldDom = null;
//Overide confirm and alert functions in order to insert an event.
let oldConfirm = confirm;
confirm = function(message){
    let confirmed;
    let location = window.location.pathname + window.location.search;
    if(message)
    {
        confirmed = oldConfirm(message);
    }
    else
    {
        confirmed = oldConfirm();
    }
    confirmEvent(message, location, confirmed)
    return confirmed;
};

let oldAlert = alert;
alert = function(message){
    let location = window.location.pathname + window.location.search;

    if(message)
    {
        oldAlert(message)
    }
    else
    {
        oldAlert();
    }

    alertEvent(message,location)
}

//Configuration in order to track DOM changes on the body
$jQGuard(document).ready(function(){
    console.log("New page loaded");
    var targetNode = document.body;
    var config = {
    attributes : true,
    childList : true,
    subtree : true
    };

    //Set onclick events on all elements of the page + snapshot of dom
    eventLink();
    copyOldDom();

    //Reset onclick events on all elements  + snapshot of dom if dom changes
    var callback = function(mutationsList, observer){
        eventLink();
        copyOldDom();
    };

    var observer = new MutationObserver(callback);
    observer.observe(targetNode, config);
})

/*******************************************************************************************************/
//                                      STORE EVENTS
/*******************************************************************************************************/

function confirmEvent(message, location, confirmed)
{
    let dom_outer_html = oldDom.getElementsByTagName('html')[0].outerHTML;
    let name;
    if(!message)
    {
        message = "";
    }


    if(confirmed)
    {
        name = "CONFIRMACCEPT";
    }
    else
    {
        name = "CONFIRMCANCEL";
    }

    let event =
    {
        name : name,
        value : null
    }

    let options = {
        message : message
    }

    post(location, event, options, dom_outer_html);
}

function alertEvent(message,location)
{
    
    if(!message)
    {
        message = "";
    }

    let dom_outer_html = oldDom.getElementsByTagName('html')[0].outerHTML;
    
    let event = 
    {
        name : "ALERTSHOW",
        value : null
    }

    let options = {
        message : message
    };
    post (location, event, options, dom_outer_html);
}

function clickEvent(entity, element, location)
{
    updateValueOldDOm(entity);
    let dom_outer_html = getOldDomOuterHTML(entity);


    var event  = 
    {
        name : element.toUpperCase() + "CLICK",
        value : null
    };
    var options = createOptions(entity,entity.innerHTML, entity.id)

    post(location, event, options, dom_outer_html, entity.id);
}

function focusEvent(entity, element, location)
{
    let dom_outer_html = getOldDomOuterHTML(entity);
    var event = 
    {
        name : element.toUpperCase() + "FOCUS",
        value : null
    };

    var options = createOptions(entity, entity.innerHTML, entity.id);
    post(location, event, options, dom_outer_html, entity.id);
}

function blurEvent(entity, element, location)
{
    updateValueOldDOm(entity);
    let dom_outer_html = getOldDomOuterHTML(entity);
    var event = 
    {
        name : element.toUpperCase() + "BLUR",
        value : entity.value
    };
    var options = createOptions(entity, entity.innerHTML, entity.id);
    post(location, event, options, dom_outer_html, entity.id);
}

function changeEvent(entity, element, location)
{
    //Update value of entity with change and put it in value

    let dom_outer_html = getOldDomOuterHTML(entity);
    var event = 
    {
        name: element.toUpperCase() + "CHANGE",
        value : entity.options[entity.selectedIndex].innerHTML
    };
    var options = createOptions(entity, entity.innerHTML, entity.id);
    post(location, event, options, dom_outer_html, entity.id);
}





/******************************************************************************************************/
//                                      EVENT PART
/******************************************************************************************************/

clickEntities = ["a","button", "input","select"];
inputEntities = ["input", "textarea"];
changeEntities = ["select"];

let entitiesClickedMarked = [];
let entitiesInputMarked = [];
let entitiesChangeMarked = [];


//Get inner HTML of entities collections in a string
function getInnerHtmlCollection(collection)
{
  if (collection.length == 0)
  {
    return undefined;
  }

  innerHtml = "";
  for(i = 0; i < collection.length; i++)
  {
    if (i == 0)
    {
      innerHtml = innerHtml + collection[i].innerHTML;
    }
    else
    {
      innerHtml = innerHtml + "," +  collection[i].innerHTML;
    }
  }
  return innerHtml;
}

//Return options object
function createOptions(element,name, id)
{
    h1 = getInnerHtmlCollection(document.getElementsByTagName("h1"));
    title = document.title;

    if(id === '')
    {
        xpath = '/' + this.getElementXPath(element);
        
        var options = 
        {
            name : name,
            xpath: xpath,
            h1 : h1,
            title : document.title
        }
    }
    else
    {
        var options = 
        {
            name : name,
            html_entity_id : id,
            h1 : h1,
            title : document.title
        }
    }


    //Delete undefined fileds in options
    Object.keys(options).forEach(key => {
    if (options[key] === undefined){
        delete options[key];
    }
    })
    return options;
}


function isEntityMarked(markedEntities, entityToCheck)
{
    let i;
    for(i=0; i< markedEntities.length; i++)
    {
        
        let entityMarked = markedEntities[i];
        if(entityToCheck.entity === entityMarked.entity &&  entityToCheck.id === entityMarked.id && entityToCheck.xpath === entityMarked.xpath)
        {
            return true;
        }
    }
    return false;
}

function eventForCatchingEvents(){};

//Bind events to html entities
function eventLink()
{ 
  $jQGuard(document).ready(function()
  {
    var location = window.location.pathname + window.location.search;

    // bind click event on clickEntitites
    clickEntities.forEach(function(element){
        $jQGuard(element).unbind("click");
        let entities = $jQGuard(element);
        entities.each(function(){
            let entity = $jQGuard(this).get()[0];

            //Get onclick in entity, to call it after our event
            let onclickString = $jQGuard(this).attr("onclick");
            let func = null;
            if(onclickString)
            {
                $jQGuard(this).removeAttr("onclick");
                func = new Function(onclickString);
            }

            

            let entityToCheck = {
                entity : entity,
                id : entity.id,
                xpath : getElementXPath(entity)
            }

            if((element === "input" && entity.type != "text") || element !== "input")
            {
                if(!isEntityMarked(entitiesClickedMarked, entityToCheck))
                {   
                    entity.addEventListener("click",eventForCatchingEvents, entity, element, location, func);
                    entitiesClickedMarked.push(entityToCheck);
                }
            }
            
        })
    });

    inputEntities.forEach(function(element){


        let entities = $jQGuard(element);
        entities.each(function(){
            let entity = $jQGuard(this).get()[0];

            let entityToCheck = {
                entity : entity,
                id : entity.id,
                xpath : getElementXPath(entity)
            }

            if(entity.type === "text" || entity.type === "textarea")
            {
                if(!isEntityMarked(entitiesInputMarked, entityToCheck))
                {
                    entity.addEventListener("focus", eventForCatchingEvents, entity, element, location);
                    entity.addEventListener("blur", eventForCatchingEvents, entity, element, location);
                    entitiesInputMarked.push(entityToCheck);
                }
            }
        })
    });

    changeEntities.forEach(function(element){
        let entities = $jQGuard(element);
        entities.each(function(){
            let entity = $jQGuard(this).get()[0];

            let entityToCheck = {
                entity : entity,
                id: entity.id,
                xpath: getElementXPath(entity)
            };

            if(!isEntityMarked(entitiesChangeMarked, entityToCheck))
            {
                entity.addEventListener("change", eventForCatchingEvents, entity, element, location);
                entitiesChangeMarked.push(entityToCheck);
            }
        })
    })

  });
}


/*******************************************************************************************************/
//                                          EXE
/*******************************************************************************************************/

function getHrefWithoutFile(href)
{
    if(href)
    {
        let test = href.split('/');
        let recompose = "";
        for(let i = 0; i < test.length - 1; i++)
        {
            recompose = recompose + test[i] +'/';
        }
        return recompose;
    }
    return null;
}

//Copy and keep oldDom in memory, with updated values in input entities
function copyOldDom()
{
    var domCopy = document.cloneNode(true);
    var copyHTML = domCopy.getElementsByTagName('html')[0];
    var copyInputs = copyHTML.getElementsByTagName('input');

    for (i = 0; i < copyInputs.length; i++)
    {
       if(copyInputs[i].type == "checkbox")
       {
        copyInputs[i].defaultChecked = $jQGuard(copyInputs[i]).is(':checked');
       }
       else
       {
            var att = document.createAttribute("value");
            att.value = $jQGuard(copyInputs[i]).val();
            copyInputs[i].setAttributeNode(att);
       }
    }

    var links = copyHTML.getElementsByTagName('link');
    for(i=0; i < links.length; i++)
    {
        let link = links[i];
        if(link.href)
        {
            let newhref = link.href;
            link.href = newhref;
        }
    }

    var scripts = copyHTML.getElementsByTagName('script');
    for(i=0; i < scripts.length; i++)
    {
        let script = scripts[i];
        if(script.src)
        {
            let newsrc = script.src;
            script.src = newsrc;
        }
    }

    var imgs = copyHTML.getElementsByTagName('img');
    for(i=0; i < imgs.length; i++)
    {
        let img = imgs[i];
        if(img.src)
        {
            let newsrc = img.src;
            img.src = newsrc;
        }
    }

    oldDom = domCopy;
}

function getOldDomOuterHTML(element)
{
    var copyOldDom = oldDom.cloneNode(true);
    var elementsSameTag = copyOldDom.getElementsByTagName('html')[0].getElementsByTagName(element.tagName);

    if(element.id)
    {
        for(i=0; i < elementsSameTag.length; i++)
        {
            if(elementsSameTag[i].id == element.id)
            {
                elementsSameTag[i].style.border = "3px dashed green";
                if(elementsSameTag[i].type == "checkbox")
                {
                    elementsSameTag[i].style.outline = "3px dashed green";
                    
                }
                
            }
        }
    }
    else
    {
        var elementPath =  getElementXPath(element);
        var path = null;

        for(i=0; i < elementsSameTag.length; i++)
        {
            path = getElementXPath(elementsSameTag[i]);
            if(path == elementPath)
            {
                elementsSameTag[i].style.border = "3px dashed green";
                if(elementsSameTag[i].type == "checkbox")
                {
                    elementsSameTag[i].style.outline = "3px dashed green";
                    
                }
            }
        }
        
    }
    
    return copyOldDom.getElementsByTagName('html')[0].outerHTML;
}

function getEntitiesInOldDom(htmlEntity, tagName)
{
    let entity = null;
    var oldDomEntities = oldDom.getElementsByTagName('html')[0].getElementsByTagName(tagName);

    if(htmlEntity.id)
    {
        for(i = 0; i < oldDomEntities.length; i++)
        {
            if(oldDomEntities[i].id == htmlEntity.id)
            {
                entity = oldDomEntities[i];
            }
        }
    }
    else
    {
        var htmlEntityPath =  getElementXPath(htmlEntity);
        var path = null;

        for(i = 0; i < oldDomEntities.length; i++)
        {
            path = getElementXPath(oldDomEntities[i]);
            if(path == htmlEntityPath)
            {
                entity = oldDomEntities[i];
            }
        }
    }

    return entity;
}

function updateValueOldDOm(htmlEntity)
{
    let entity = null;

    if(htmlEntity.tagName === "INPUT")
    {
        entity = getEntitiesInOldDom(htmlEntity, 'input');
    }

    if(htmlEntity.tagName === "SELECT")
    {
        entity = getEntitiesInOldDom(htmlEntity, 'select');
    }
    
    if(entity)
    {
        if(entity.tagName === "SELECT")
        {
            entity.options[entity.selectedIndex].removeAttribute("selected");
            entity.options[htmlEntity.selectedIndex].setAttribute("selected", true);
        }
        else if(entity.type == "checkbox")
        {
            entity.defaultChecked = $jQGuard(htmlEntity).is(':checked');
        }
        else
        {
            var att = document.createAttribute("value");
            att.value = $jQGuard(htmlEntity).val();
            entity.setAttributeNode(att);
        }
    }   
}

