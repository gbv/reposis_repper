
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

  // activate empty search on start page
  $("#pp-searchMainPage").submit(function (evt) {
    $(this).find(":input").filter(function () {
          return !this.value;
      }).attr("disabled", true);
    return true;
  });

  // open search bar
  $( ".js-search-toggler" ).click(function() {
    $( ".searchfield_box" ).addClass('open');
    $( this ).addClass('closed');
    $( "#searchbar" ).focus();
  });
  // close searchbar
  // listen to all clicks
  $(document).click(function(event) {
    var $click = $(event.target);
    // search bar is visible AND
    // clicked element is not inside of the search bar AND
    // clicked element is not the toggle itself
    if( $('.searchfield_box').hasClass("open") &&
        !$click.closest('.js-searchbar').length &&
        !$click.closest('.js-search-toggler').length ||
        $click.closest('.js-search-close').length) {
      $( ".searchfield_box" ).removeClass('open');
      $( ".search-button" ).removeClass('closed');
    }
  });

  // show all institutions
  $( ".js-show-all-institutions" ).click(function( event ) {
    $( ".page-section__institutions" ).addClass('hide-slider');
    event.stopPropagation();
    return false;
  });

  //  change alignment of main menu
  $(".pp-main-nav .nav-item > .dropdown-menu").addClass("dropdown-menu-right");
  $(".pp-main-nav #basket-list-item > .dropdown-menu").addClass("dropdown-menu-right");
});