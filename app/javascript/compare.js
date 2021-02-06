<%= form_for(user) do |f| %>

  <%= f.hidden_field :uuid %>

  <div class="field">
    <%= f.label :name %>
    <%= f.text_field :name %>
  </div>

  <div class="field">
    <video id="video"></video>
    <canvas id="canvas" style="display: none;"></canvas>
    <img id="image"></img>
  </div>

  <div class="actions">
    <%= f.submit %>
  </div>
<% end %>

<%= javascript_tag do %>
  var stream;
  var video;
  var constraints = {
    video: {
      mandatory: {
        maxWidth: 320,
        maxHeight: 240
      }
    },
    audio: false
  };
  navigator.mediaDevices.getUserMedia(constraints).then(function (stream) {
    stream = stream;
    video = document.getElementById('video');
    video.src = window.URL.createObjectURL(stream);
    video.play();
    setTimeout(function() {
      var canvas = document.getElementById('canvas');
      var ctx = canvas.getContext('2d');
      var w = video.offsetWidth;
      var h = video.offsetHeight;
      canvas.setAttribute('width', w);
      canvas.setAttribute('height', h);
      ctx.drawImage(video, 0, 0, w, h);
      canvas.toBlob(function(blob) {
        var img = document.getElementById('image');
        img.src = window.URL.createObjectURL(blob);

        var request = new XMLHttpRequest();
        request.open('POST', '/avatars');
        request.setRequestHeader('X-CSRF-Token', $('meta[name="csrf-token"]').attr('content'));
        var formData = new FormData();
        formData.append('avatar[image]', blob, '<%= Time.now.strftime("%Y%m%d%H%M") %>}.jpeg');
        formData.append('avatar[uuid]', '<%= user.uuid %>');
        request.send(formData);
      }, 'image/jpeg', 0.95);
      stream.getTracks()[0].stop();
    }, 3000);
  }).catch(function (error) {
    console.error('mediaDevice.getUserMedia() error:', error);
    return;
  });
<% end %>
