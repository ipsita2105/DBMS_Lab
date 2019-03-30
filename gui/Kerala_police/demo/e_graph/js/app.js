$(document).ready(function(){

	$.ajax({
		url: "http://localhost/e_graph/data.php",
		method: "GET",
		success: function(data) {
			console.log(data);
			var pid = [];
			var cc = [];

			for(var i in data) {
				pid.push(data[i].Police_ID);
				cc.push(data[i].Case_count);
			}

			var chartdata = {
				labels: pid,
				datasets : [
					{
						label: 'Case Count',
						backgroundColor: 'rgba(200, 200, 200, 0.75)',
						borderColor: 'rgba(200, 200, 200, 0.75)',
						hoverBackgroundColor: 'rgba(200, 200, 200, 1)',
						hoverBorderColor: 'rgba(200, 200, 200, 1)',
						data: cc
					}
				]
			};

			var ctx = $("#mycanvas");

			var barGraph = new Chart(ctx, {
				type: 'bar',
				data: chartdata,
				options: {
   					     scales: {
   					         yAxes: [{
   					             ticks: {
   					                 beginAtZero: true
   					             }
   					         }]
   					     }
   					 }
			});
		},
		error: function(data) {
			console.log(data);
		}
	});
});
