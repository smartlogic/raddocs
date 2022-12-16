function mirror(textarea, contentType, options) {
  $textarea = $(textarea);
  if ($textarea.val() != '') {
    if(contentType.indexOf('json') >= 0) {
      $textarea.val(JSON.stringify(JSON.parse($textarea.val()), undefined, 2));
      options.json = true;
      options.mode = 'javascript';
    } else if (contentType.indexOf('javascript') >= 0) {
      options.mode = 'javascript';
    } else if (contentType.indexOf('xml') >= 0) {
      options.mode = 'xml';
    } else {
      options.mode = 'htmlmixed';
    }
  }
  return CodeMirror.fromTextArea(textarea, options);
};

$(function(){
  $(".request .body .content").each(function(i, el) {
    el = $(el);
    mirror(el.find("textarea")[0], el.data("content-type"), { "readOnly": true, "lineNumbers": true });
  });
});
