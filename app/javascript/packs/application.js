// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.

import Rails from "@rails/ujs"
import Turbolinks from "turbolinks"
import * as ActiveStorage from "@rails/activestorage"
import "channels"

import "jquery";
import "popper.js";
import "bootstrap";
import "../stylesheets/application"
import '../stylesheets/mystyle.css'
import '@fortawesome/fontawesome-free/js/all'

//= require jquery
//= require rails-ujs


Rails.start()
Turbolinks.start()
ActiveStorage.start()

/* global $*/
$(document).on('turbolinks:load', function() {
  $(function() {
    $('.tab').click(function(){
      $('.tab-active').removeClass('tab-active');
      $(this).addClass('tab-active');
      $('.box-show').removeClass('box-show');
      const index = $(this).index();
      $('.tabbox').eq(index).addClass('box-show');
    });
  });
});

$("#form-check-input").click(function(){
    var $count = $("#form-check-input:checked").length;
    var $not = $("#form-check-input").not(':checked')

    if($count >= 3) {
        $not.attr("disabled",true);
    }else{
        $not.attr("disabled",false);
    }
});