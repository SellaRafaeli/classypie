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
    var first = _.sample(["Abe","Bob","Carl","Danny","Eve"]);
    var last  = _.sample(["Aaronson","Berkeley","Cohen","Davis","Elm"]);
    var num = _.random(0,1000);
    return first+" "+last+" "+num;
}