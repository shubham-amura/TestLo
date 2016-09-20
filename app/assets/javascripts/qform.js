$(document).ready(function(){

    toggleOptions();
    toggelCorrectOptions();
});

function toggleOptions()
{
  var options=$('#options');
  var a0=$('#correct_answers_0');
  var a1=$('#correct_answers_1');
  var a2=$('#correct_answers_2');

  $('#question_question_type_0').change(function(){
    options.toggle(!options.is(':visible'));
    a0.show();
    a1.hide();
    a2.hide();
  });

  $('#question_question_type_1').change(function(){
      if(options.is(':hidden'))
      {
        options.show();
      }
      a1.show();
      a0.hide();
      a2.hide();
  });


  $('#question_question_type_2').change(function(){
      if(options.is(':hidden'))
      {
        options.show();
      }
      a2.show();
      a0.hide();
      a1.hide();
  });
}

function toggelCorrectOptions()
{
}
