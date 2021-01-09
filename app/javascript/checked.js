function check() {
  const comments = document.querySelectorAll(".comment");
  comments.forEach(function (comment) {
    if (comment.getAttribute("data-load") != null) {
      return null;
    }
    comment.setAttribute("data-load", "true");
    comment.addEventListener("click", () => {
      const commentId = comment.getAttribute("data-id");
      const XHR = new XMLHttpRequest();
      XHR.open("GET", `/posts/:post_id/comments/${commentId}`, true);
      XHR.responseType = "json";
      XHR.send();
      XHR.onload = () => {
        if (XHR.status != 200) {
          alert(`Error ${XHR.status}: ${XHR.statusText}`);
          return null;          
        }
        const item = XHR.response.comment;
        if (item.checked === true) {
          comment.setAttribute("data-check", "true");
        } else if (item.checked === false) {
          comment.removeAttribute("data-check");
        }
      };
    });
  });
}
setInterval(check, 1000);