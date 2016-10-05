$(document).ready(function(){

  // alert('hello');

  var myVar = setInterval(myTimer,1000);
});

function myTimer()
 {
   var total_time=$('div .timer :first-child').html();
   total_time=parseInt(total_time);
  // console.log(total_time);

   var start_time=$('div .timer :last-child').html();
   start_time=parseInt(start_time);
  // console.log(start_time);

   var now=new Date();

   var current_time=now.getHours()*60*60 + now.getMinutes()*60 + now.getSeconds()
  //  console.log(current_time);
   var secs=total_time-(current_time-start_time)

   $('.countdown :first-child').html(convert(secs));
  //  alert(convert(secs));

  // alert(convert());
  //  var d=new Date();
  //   // alert(total_time);
    // alert('timer');
}


function convert(totalSec)
{
// var totalSec = new Date().getTime() / 1000;

if(totalSec==0)
{
  timeUP();
}
var hours = parseInt( totalSec / 3600 ) % 24;
var minutes = parseInt( totalSec / 60 ) % 60;
var seconds = totalSec % 60;

var result = (hours < 10 ? "0" + hours : hours) + ":" + (minutes < 10 ? "0" + minutes : minutes) + ":" + (seconds  < 10 ? "0" + seconds : seconds);
return result;
}


function timeUP()
{
  $.ajax({
      type: "GET",
      url: document.URL+"/finish.js",
      success:function(data)
      {
          alert('time up');
      },

       error:function(data){
           alert('failed');
       }
    });
  //alert("Times Up");
  //send ajax to finish action here

}
