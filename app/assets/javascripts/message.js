
// Jqueyの処理を記載するためにファイル作成

$(function(){

  // var last_message_id = $('.message:last').data("message-id");
  // console.log(last_message_id);

  var reloadMessages = function(){
    
    //カスタムデータ属性を利用し、ブラウザに表示されている最新メッセージのidを取得
    var last_message_id = $('.message-block:last').data("message-id");
    

    $.ajax({
      //ルーティングで設定した通り/groups/id番号/api/messagesとなるよう文字列を書く
      url: "api/messages",
      //ルーティングで設定した通りhttpメソッドをgetに指定
      type: 'get',
      dataType: 'json',
      //dataオプションでリクエストに値を含める
      data: {id: last_message_id}
    })
    .done(function(messages){

      if (messages.length !== 0) {
     
      //追加するHTMLの入れ物を作る
      var insertHTML = '';
      //配列messagesの中身一つ一つを取り出し、HTMLに変換したものを入れ物に足し合わせる
      $.each(messages, function(i, message) {
        insertHTML += buildHTML(message)
      });
      //メッセージが入ったHTMLに、入れ物ごと追加
      $('.chat-main__message-list').append(insertHTML);
      $('.chat-main__message-list').animate({ scrollTop: $('.chat-main__message-list')[0].scrollHeight});
      // $('.messages').animate({ scrollTop: $('.messages')[0].scrollHeight});
    
      }
    })
    .fail(function(){
      alert('error');
    });


  };


  function buildHTML(message){
    if( message.image){
      var html =
      `
      <div class="message-block" data-message-id=${message.id}>
            <div class="message-block__name">
              <div>
                ${message.user_name}
              </div>
              <div class="message-date">
                ${message.created_at}
              </div>
            </div>
            <div class="message-block__text">
              <p class="lower-message__content">
                ${message.content}
              </p>
            </div>
            <div class="message-block__empty-block">
            <img src=${message.image} >
            </div>
      </div>`
      return html;
    } else {
      var html = 
      `
      <div class="message-block" data-message-id=${message.id}>
            <div class="message-block__name">
              <div>
                ${message.user_name}
              </div>
              <div class="message-date">
                ${message.created_at}
              </div>
            </div>
            <div class="message-block__text">
              <p class="lower-message__content">
                ${message.content}
              </p>
            </div>
  
      </div>
      `
      return html;
    }

  }
  $("#new_message").on("submit" , function(e){
    e.preventDefault();
    // console.log("Hello");
    var formData = new FormData(this);
    var url = $(this).attr('action')

    $.ajax({
      url: url,
      type: 'POST',
      data: formData,
      dataType: 'json',
      processData: false,
      contentType: false
    })
    .done(function(argument){
      var html = buildHTML(argument);
      $('.chat-main__message-list').append(html);
      $(".form__submit").removeAttr("disabled");
      $('.chat-main__message-list').animate({ scrollTop: $('.chat-main__message-list')[0].scrollHeight});
      $('form')[0].reset();
  
    })
    .fail(function() {
      alert("メッセージ送信に失敗しました");
      $(".form__submit").removeAttr("disabled");
    });
  })
  if (document.location.href.match(/\/groups\/\d+\/messages/)) {
    setInterval(reloadMessages, 2000);
  }
});

