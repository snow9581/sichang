function limit() {
    var ggch = document.getElementById("GGXH"); ggch.disabled = true; 
    var ccbh = document.getElementById("CCBH"); ccbh.disabled = true; 
    var zqddj = document.getElementById("ZQDDJ"); zqddj.disabled = true; 
    var sccj = document.getElementById("SCCJ"); sccj.disabled = true; 
    var jdjg = document.getElementById("JDJG"); jdjg.disabled = true;
    $('#YBMC').attr('disabled', 'disabled');
}
limit();
function saveItem(index) {
    var id = $('#ID').val();
    var company = $('#COMPANY').val();
    var competemt = $('#COMPETENT').val();
    var checker = $('#CHECKER').val();
    var texter = $('#TEXTER').val();
    var textdate = $('#TEXTDATE').datebox('getValue');
    var validdate = $('#VALIDDATE').datebox('getValue');
    var data1 = $('#DATA1').val();
    var data2 = $('#DATA2').val();
    var data3 = $('#DATA3').val();
    var data9 = $('#DATA9').val();
    var data10 = $('#DATA10').val();
    var data11 = $('#DATA11').val();
    var data12 = $('#DATA12').val();
    var data13 = $('#DATA13').val();
    var data14 = $('#DATA14').val();
    var data15 = $('#DATA15').val();
    var data16 = $('#DATA16').val();
    var data17 = $('#DATA17').val();
    var data18 = $('#DATA18').val();
    var data19 = $('#DATA9').val();
    var data20 = $('#DATA20').val();
    var data21 = $('#DATA21').val();
    var data22 = $('#DATA22').val();
    var data23 = $('#DATA23').val();
    var data24 = $('#DATA24').val();
    var data25 = $('#DATA25').val();
    var data26 = $('#DATA26').val();
    var data27 = $('#DATA27').val();
    var data28 = $('#DATA28').val();
    var data29 = $('#DATA29').val();
    var data30 = $('#DATA30').val();
    var data31 = $('#DATA31').val();
    var data32 = $('#DATA32').val();
    var data33 = $('#DATA33').val();
    var data34 = $('#DATA34').val();
    var data35 = $('#DATA35').val();
    var data36 = $('#DATA36').val();
    var data37 = $('#DATA37').val();
    var data38 = $('#DATA38').val();
    var max = $('#MAXERROR').val();
    var texted = $('#TEXTED').val();
    $.ajax({
        type: "post",
        url: "insert_test.ashx",
        data: {
            COMPANY: company, COMPETENT: competemt, CHECKER: checker, TEXTER: texter, VALIDDATE: validdate,TEXTDATE:textdate,
            DATA1: data1, DATA2: data2, DATA3: data3,DATA:data9,DATA10: data10, DATA11: data11, DATA12: data12, DATA13: data13,
            DATA14: data14, DATA15: data15, DATA16: data16, DATA17: data17, DATA18: data18, DATA19: data19, DATA20: data20,
            DATA21: data21, DATA22: data22, DATA23: data23, DATA24: data24, DATA25: data25, DATA26: data26, DATA27: data27,
            DATA28: data28, DATA29: data29, DATA30: data30, DATA31: data31, DATA32: data32, DATA33: data33, DATA34: data34,
            DATA35:data35,DATA36:data36,DATA37:data37,DATA38:data38,MAXERROR:max,ID:id,TEXTED:texted
        },
        async: false,
        success: function (data) {
            $('#cc').layout('remove', 'north');
            $('#dg').datagrid('reload');
        }
    });
}
var height = $('#left').height();
$("#right").css("height", height);
function myformatter(date) {
    var y = date.getFullYear();
    var m = date.getMonth() + 1;
    var d = date.getDate();
    return y + '-' + (m < 10 ? ('0' + m) : m) + '-' + (d < 10 ? ('0' + d) : d);
}
function myparser(s) {
    if (!s)
        return new Date();
    var ss = (s.split('-'));
    var y = parseInt(ss[0], 10);
    var m = parseInt(ss[1], 10);
    var d = parseInt(ss[2], 10);
    if (!isNaN(y) && !isNaN(m) && !isNaN(d)) {
        return new Date(y, m - 1, d);
    } else {
        return new Date();
    }
}
$("#cancel").click(function () {
    $('#cc').layout('remove', 'north');
})
function tt() {
    var level = $('#ul').val();
    var DM = $('#hd_DM').val();
    if(DM!="仪表室"){
        save.style.display = "none"; //style中的display属性    
    }    	
}
$(document).ready(function () {
    tt();
});
