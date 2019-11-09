var formEl = document.getElementById("form");

formEl.addEventListener("submit", function(event) {
  var headers = new Headers();
  headers.set("Accept", "application/json");
  var data = {};
  for (var i = 0; i < formEl.length - 1; ++i) {
    data[formEl[i].name] = formEl[i].value;
  }
  data = JSON.stringify(data);
  var url = "/admin/cancelbooking/";
  var fetchOptions = {
    method: "POST",
    headers: {
      "Content-Type": "application/json; charset=UTF-8"
    },
    body: data
  };
  var responsePromise = fetch(url, fetchOptions);
  responsePromise
    .then(response => response.json())
    .then(jsonData => {
      console.log(jsonData);
      alert(jsonData.msg.Message);
    });
  event.preventDefault();
});
