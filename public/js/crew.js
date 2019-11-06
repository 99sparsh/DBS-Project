var formEl = document.getElementById("form");

formEl.addEventListener("submit", function(event) {
  var headers = new Headers();
  headers.set("Accept", "application/json");
  var data = {};
  for (var i = 0; i < formEl.length - 1; ++i) {
    data[formEl[i].name] = formEl[i].value;
  }

  var url = "/admin/addcabincrew/";
  var fetchOptions = {
    method: "POST",
    headers: {
     
      "Content-Type": "application/json; charset=UTF-8"
    },
    body: JSON.stringify(data)
  };
  var responsePromise = fetch(url, fetchOptions);
  responsePromise
    .then(function(response) {
      console.log(JSON.parse(response));
      return JSON.parse(response);
    })
    .then(function(jsonData) {
      console.log(jsonData);
      if (jsonData.success == "true") alert("Added!");
      else alert(jsonData.msg);
    });
  event.preventDefault();
});
