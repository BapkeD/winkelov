window.addEventListener('message', async (event) => {
    let data = event.data;

    if(data.type == 'showNui'){
        document.getElementById('main').style.visibility = 'visible';
    }
    if(data.type == 'CloseNui'){
        document.getElementById('main').style.visibility = 'hidden';
    }
    if(data.type == 'Overvalgestart'){
        Timer(); 
    }
    if(data.type == 'overvalgestopt'){
        
    
        document.getElementById('main').style.visibility = 'hidden';
        document.getElementById('overvalgestopt').style.visibility = 'visible';
        
        setTimeout(function() {
            document.getElementById('overvalgestopt').style.visibility = 'hidden';
        }, 5000);
    }
   
});

function Timer() {
    let tijd = 180;

    timerInterval = setInterval(() => { // Sla het interval ID op
        let minuten = Math.floor(tijd / 60);
        let seconden = tijd % 60;
        seconden = seconden < 10 ? '0' + seconden : seconden;

        document.getElementById('main').innerHTML = `Overval gestart. Blijf in de winkel voor ${minuten}:${seconden}`;

        tijd--;
        
        if (tijd < 0) {
            clearInterval(timerInterval); // Stop de timer als de tijd op is
            document.getElementById('main').innerHTML = `Overval voltooid.`;
            setTimeout(function() {
                document.getElementById('main').style.visibility = 'hidden';
            }, 5000);
            
        }

    }, 1000);
}

