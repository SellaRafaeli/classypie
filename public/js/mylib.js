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