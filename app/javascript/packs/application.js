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
  /*
    ---
    タブの初期値制御
    https://pisuke-code.com/js-ways-to-retrive-get-params/#URLsearchParams
    https://stocker.jp/diary/nth-child/
    ---
  */
  // URLのGetParameterを取得する
  var params = (new URL(document.location)).searchParams;
  var tab = params.get('tab');

  if (tab !== null) {
    // GetParameterのtabがnullでない場合
    $('.tab-list').children().removeClass('tab-active') // .tab-listの子要素のtab-activeをすべて削除
    $(`.tab-list > li:nth-child(${tab})`).addClass('tab-active') // .tab-listのliタグをタブの位置でクラス付与
    $('.tabbox-contents').children().removeClass('box-show') // .tabbox-contentsの子要素のbox-showをすべて削除
    $(`.tabbox-contents > div:nth-child(${tab})`).addClass('box-show') // .tabbox-contentsのdivタグをタブの位置でクラス付与
  }

  /*
    ---
    タブの表示制御
    ---
  */

  $(function() {
    $('.tab').click(function(){
      // .tab-active自身のクラスを削除
      $('.tab-active').removeClass('tab-active');
      // 自分自身(クリックされたところ)にtab-activeを付与
      $(this).addClass('tab-active');
      // .box-show自身のクラスを削除
      $('.box-show').removeClass('box-show');
      // (1) 自分自身(クリックされたところ)の順番を0を起点として取得
      const index = $(this).index();
      // .tabboxで(1)で算出した場所の.tabboxにbox-showを付与
      $('.tabbox').eq(index).addClass('box-show');
    });
  });

  /*
    ---
    タグの選択制限
    http://kachibito.net/snippets/limit-checkbox-amount
    https://feeld-uni.com/entry/2021/01/28/172608
    ---
  */
  $('.tag > .form-check > label > input[type=checkbox]').click(function(){
    // (1) .tagの中の.form-checkの中のlabelに囲われたチェックボックスの数をjQueryのlengthメソッドで取得
    var count = $('.tag > .form-check > label > input[type=checkbox]:checked').length;
    // (2) .tagの中の.form-checkの中のlabelに囲われたチェックボックスのチェックされていないチェックボックス一覧を取得
    var not = $('.tag > .form-check > label > input[type=checkbox]').not(':checked')

    if(count >= 3) { // (1)が3つ以上とき
      not.attr("disabled",true); // チェックボックス無効化
    } else {
      not.attr("disabled",false); // チェックボックス有効化
    }
  });
});

$(function(){
  $('.flash').slideUp(4000);
});

