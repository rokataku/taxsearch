 // getUserMedia が使えないときは、『getUserMedia()が利用できないブラウザです！』と言ってね。
 if (typeof navigator.mediaDevices.getUserMedia !== 'function') {
  const err = new Error('getUserMedia()が利用できないブラウザです！');
  alert(`${err.name} ${err.message}`);
  throw err;
}

// 操作する画面エレメント変数定義します。
const $start = document.getElementById('start_btn');   // スタートボタン
const $video = document.getElementById('video_area');  // 映像表示エリア

// 「スタートボタン」を押下したら、getUserMedia を使って映像を「映像表示エリア」に表示してね。
$start.addEventListener('click', () => {
  navigator.mediaDevices.getUserMedia({ video: true, audio: false })
  .then(stream => $video.srcObject = stream)
  .catch(err => alert(`${err.name} ${err.message}`));
}, false);


// 「静止画取得」ボタンが押されたら「<canvas id="capture_image">」に映像のコマ画像を表示します。
function copyFrame() {

  var canvas_capture_image = document.getElementById('capture_image');
  var cci = canvas_capture_image.getContext('2d');
  var va = document.getElementById('video_area');

  canvas_capture_image.width  = va.videoWidth;
  canvas_capture_image.height = va.videoHeight;
  cci.drawImage(va, 0, 0);  // canvasに『「静止画取得」ボタン』押下時点の画像を描画。
}