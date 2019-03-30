$(document).ready(function(){

	$.ajax({
		
		url: "http://localhost/graph/data.php",
		method: "GET",
		success: function(data){
			console.log(data);
			var crime_type = [];
			var crime_count = [];

			for(var i in data){
				crime_type.push(data[i].Crime_Type);
				crime_count.push(data[i].Crime_Count);
			}

			var chartdata = {
				labels: crime_type,
				datasets: [
					{
						label: 'Crime_Count',
						backgroundColor: 'rgba(200, 200, 200, 0.75)',
						borderColor: 'rgba(200, 200, 200, 0.75)', 
						hoverBackgroundColor: 'rgba(200, 200, 200, 1)',
						hoverBorderColor: 'rgba(200, 200, 200, 1)',
						data: crime_count 
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

		error: function(data){
			console.log(data);
		}
	
	});



});
