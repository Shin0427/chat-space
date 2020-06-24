
// Jqueyの処理を記載するためにファイル作成

$(function(){

  function buildHTML(message){
    if( message.image){
      var html =
      `
      <div class="message-block">
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
      <div class="message-block">
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
});

