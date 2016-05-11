
var GDP;

Plotly.d3.csv('/free/China-econ/GDP-growth.csv', function(err, rows){

    function unpack(rows, key) {
        return rows.map(function(row) { return row[key]; });
    }

    var Year = unpack(rows, 'year'); 
    var GDPrate = unpack(rows, 'Growth(%)'); 
    GDP = unpack(rows, 'GDP($)'); 
   
    var trace1 = {
        x: Year,
        y: GDPrate, 
        name: 'Growth Rate (%)',
        type: 'bar'
    };

    var trace2 = {
        x: Year,
        y: GDP, 
        name: 'GDP ($)',
        yaxis: 'y2', 
        type: 'scatter'
    };
   
    //console.log(GDPrate); 
    //console.log(GDP); 
 
    var data = [ trace1, trace2 ];  

    var layout = {
        title: 'China GDP and Growth Rate',
        xaxis: {title: 'Year', dtick: 1, tickangle: 45}, 
        yaxis: {title: 'GDP Growth Rate (%)', range: [3, 15], 
                titlefont: {color: '#1f77b4'},
                tickfont: {color: '#1f77b4'} 
                }, 
        yaxis2: {title: 'GDP ($)', overlaying: 'y', side: 'right', 
                 titlefont: {color: '#ff7f0e'},
                 tickfont: {color: '#ff7f0e'} 
        }, 
        showlegend: true
    };

    Plotly.plot('topwin', data, layout, {showLink: false, displaylogo: false});

});

