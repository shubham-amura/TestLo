$(document).ready(function(){

    toggleOptions();

});

function toggleOptions()
{
    //alert('Hello');
    $('#correct_answers_3').hide();
    $('#question_question_type_0').change(hideOptions);
    $('#question_question_type_1').change(showOptions);
    //$('#question_question_type_2').change(showOptions);

}

function hideOptions()
{
    $('#options').hide();
    $('#correct_answers_3').show();
    $('#correct_answers_1').hide();
    //$('#options').children().remove();
}

function showOptions()
{
    $('#options').show();
    $('#correct_answers_3').hide();
    $('#correct_answers_1').show();


}
