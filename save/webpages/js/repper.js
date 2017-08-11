
$(document).ready(function() {

  // replace placeholder USERNAME with user name
  var userID = $("#currentUser strong").html();
  var newHrefShort = 'http://perspectivia.gbv.de/servlets/solr/select?q=createdby:' + userID + '&fq=objectType:mods';
  $("a[href='http://perspectivia.gbv.de/servlets/solr/select?q=createdby:USERNAME']").attr('href', newHrefShort);
  var newHrefTest = 'http://reposis-test.gbv.de/repper/servlets/solr/select?q=createdby:' + userID + '&fq=objectType:mods';
  $("a[href='http://reposis-test.gbv.de/repper/servlets/solr/select?q=createdby:USERNAME']").attr('href', newHrefTest);


  // spam protection for mails
  $('span.madress').each(function(i) {
      var text = $(this).text();
      var address = text.replace(" [at] ", "@");
      $(this).after('<a href="mailto:'+address+'">'+ address +'</a>')
      $(this).remove();
  });

});