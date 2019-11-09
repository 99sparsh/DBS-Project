var formEl = document.getElementById("form");

formEl.addEventListener("submit", function(event) {
  var pilot = document.getElementById("pilot");
  var bus = document.getElementById("bus");
  var gate = document.getElementById("gate");
  var dest = document.getElementById("dest");
  var date = document.getElementById("date");
  var airplane = document.getElementById("plane");
  var data = {
    // pilot: pilot.options[pilot.selectedIndex].value,
    //bus: bus.options[bus.selectedIndex].value,
    //gate:parseInt(gate.options[gate.selectedIndex].value)
    gate: 1,
    pilot: 1,
    bus: 1,
    //airplane: airplane.options[airplane.selectedIndex].value,
    airplane: 1,
    date: date.value,
    dest: dest.value
  };
  console.log(data);
  data = JSON.stringify(data);

  var url = "/admin/schedule/";
  var fetchOptions = {
    method: "POST",
    headers: {
      "Content-Type": "application/json; charset=UTF-8"
    },
    body: data
  };
  console.log(fetchOptions);
  var responsePromise = fetch(url, fetchOptions);
  responsePromise
    .then(response => response.json())
    .then(jsonData => {
      console.log(jsonData);
      if (jsonData.success) alert("Added!");
      else alert(jsonData.msg);
    });
  event.preventDefault();
});
