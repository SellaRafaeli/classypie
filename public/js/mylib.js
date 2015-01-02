function just(from, fieldsArr) { 
    var res = {};
    fieldsArr.forEach(function(i) { res[i] = from[i] } );
    return res;
}

function genError(res) { console.log("res"); alert("An error occurred.") }

//http://stackoverflow.com/questions/1184624/convert-form-data-to-js-object-with-jquery
$.fn.toObj = $.fn.serializeObject = function()
{
    var o = {};
    var a = this.serializeArray();
    $.each(a, function() {
        if (o[this.name] !== undefined) {
            if (!o[this.name].push) {
                o[this.name] = [o[this.name]];
            }
            o[this.name].push(this.value || '');
        } else {
            o[this.name] = this.value || '';
        }
    });
    return o;
};

//http://stackoverflow.com/questions/7298364/using-jquery-and-json-to-populate-forms
function objToForm(form, data) {   
    form = $(form);
    $.each(data, function(key, value){  
    var $ctrl = $('[name='+key+']', form);  
    switch($ctrl.attr("type"))  
    {  
        case "text" :   
        case "hidden":  
        $ctrl.val(value);   
        break;   
        case "radio" : case "checkbox":   
        $ctrl.each(function(){
           if($(this).attr('value') == value) {  $(this).attr("checked",value); } });   
        break;  
        default:
        $ctrl.val(value); 
    }  
    });  
}

function getRandomName(){ 
    var first = _.sample(["Abe","Bob","Carl","Danny","Eve","Frank","Gertrude","Hal","Ivan","Jake","Kay"]);
    var last  = _.sample(["Aaronson","Berkeley","Cohen","Davis","Elm","Francis","Gomez","Hendeson",'Index','Jerrison','Kendrick']);
    var num = _.random(0,1000);
    return first+" "+last+" "+num;
}

function fillFormRandom(form, randFn) {
    var randFn = randFn || getRandomName;
    var keysObj = $(form).serializeObject();
    for (var key in keysObj) keysObj[key] = randFn();
    objToForm($(form), keysObj);
}

function ifEnter(func) {
    if (event.keyCode == 13 && !event.shiftKey) {
        func(event.srcElement);   
    }
}

function log(x) { console && console.log(x); }
function addPlaceholdersDefaults() {
    var elems = [].slice.call($('input').add($('textarea')));
        elems.forEach(function(el) { el.placeholder = el.placeholder || el.name });
}

function dontSubmitFormsOnEnter() {
    var checkEnter = function(e){
     e = e || event;
     var txtArea = /textarea/i.test((e.target || e.srcElement).tagName);
     return txtArea || (e.keyCode || e.which || e.charCode || 0) !== 13;
    }
    document.querySelector('form').onkeypress = checkEnter;
}

function syncInput(orig,follower) {
    orig = $(orig);
    follower = $(follower);
    orig.keyup(function(){ follower.val(orig.val()); });
    //orig.change(function(){ follower.val(orig.val()); });
}

function syncTwoInputs(a,b) { 
    syncInput(a,b);
    syncInput(b,a);
    console.log("ok, synced", a, b);
}