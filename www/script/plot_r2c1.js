
Plotly.d3.csv('/free/China-econ/thermal_power_gen.csv', function(err, rows){

    function unpack(rows, key) {
        return rows.map(function(row) { return row[key]; });
    }

    var Year = unpack(rows, 'Date'); 
    var Y = unpack(rows, 'Thermal Power Generation'); 
   
    var trace1 = {
        x: Year,
        y: Y, 
        name: 'Thermal Power Generation',
        type: 'scatter'
    };

    console.log(Year); 
    console.log(Y); 
 
    var data = [ trace1 ];  

    var layout = {
        title: 'Monthly Thermal Power Generation',
        xaxis: {type: 'date', title: 'Year'}, 
        yaxis: {title: 'Thermal Power', 
                titlefont: {color: '#1f77b4'},
                tickfont: {color: '#1f77b4'} 
                }, 
        showlegend: false 
    };

    Plotly.plot('r2c1', data, layout, {showLink: false, displaylogo: false,
                 modeBarButtonsToRemove: ['sendDataToCloud','hoverCompareCartesian']});

});

