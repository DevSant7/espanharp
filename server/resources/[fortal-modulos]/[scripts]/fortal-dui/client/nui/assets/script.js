let serverColor = [60, 142, 220]
let customColor = null
let types = [
    {
        id: "skinshop",
        style: "margin-top: 0.1rem; margin-left: 0.1rem;"
    },
    {
        id: "dealership",
        style: "margin-top: 0.1rem; margin-left: 0.05rem;"
    },
    {
        id: "tattooshop",
        style: "margin-top: 0.1rem; margin-left: 0.05rem;"
    },
    {
        id: "homes",
        style: "margin-top: 0.1rem;"
    },
    {
        id: "barbershop",
        style: "margin-top: 0.4rem; margin-left: 0.05rem;"
    },
    {
        id: "health",
        style: "margin-top: 0.4rem; margin-left: 0.05rem;"
    },
    {
        id: "weight",
        style: "margin-top: 0.1rem; margin-left: 0.05rem;"
    },
    {
        id: "key",
        style: "margin-top: 0.1rem; margin-left: 0.05rem;"
    }
]

window.addEventListener("load", () => {
    const body = document.body;
    const url = new URL(window.location);
    let div;
    
    types.map((response) => {
        if (url.searchParams.has(response.id)) {
            const data = JSON.parse(url.searchParams.get(response.id));
            
            // Armazena a cor customizada se disponível
            if (data.color) {
                customColor = data.color;
            }
            
            if (response.id) {
                div = document.createElement("div");

                div.id = data.id
                div.classList.add("container")
                div.innerHTML = `
                    <div class="header">
                        ${data.title}
                    </div>

                    <div class="inclose">
                        <img style="${response.style}" src="./assets/icons/${response.id}.svg" />
                    </div>

                    <div class="outclose"></div>
                `

                window.postMessage({
                    action: "inClose",
                    payload: {
                        id: data.id,
                        close: data.close
                    }
                })
            }   
        }
    })

    if (div) {
        body.append(div);
        
        // Aplica a cor customizada se disponível
        if (customColor) {
            applyCustomColor(customColor);
        }
    }
})

window.addEventListener("message", function({data}) { 
    if (data.payload.id) { 
        const element = document.getElementById(data.payload.id);

        if (element) {
            if (data.action === "inClose") {
                const header = element.querySelector(".header");
                const inclose = element.querySelector(".inclose");
                const outclose = element.querySelector(".outclose");

                if (data.payload.close) {
                    header.style.display = "flex";
                    inclose.style.display = "flex";
                    outclose.style.display = "none";
                } else {
                    header.style.display = "none";
                    inclose.style.display = "none";
                    outclose.style.display = "flex";
                }
            }
        }
    }
})

// Função para aplicar cor customizada
function applyCustomColor(color) {
    const root = document.documentElement;
    
    // Converte RGB para valores CSS
    const rgb = `${color.r}, ${color.g}, ${color.b}`;
    
    // Define a variável CSS customizada para o header
    root.style.setProperty('--primary-color', rgb);
    
    // Calcula o filtro hue-rotate para os hexágonos SVG
    // Converte RGB para HSV e calcula o hue-rotate necessário
    const hue = rgbToHue(color.r, color.g, color.b);
    const hueRotate = hue - 210; // 210 é o hue do azul original
    
    // Aplica o filtro aos hexágonos
    const incloseElements = document.querySelectorAll('.inclose');
    const outcloseElements = document.querySelectorAll('.outclose');
    
    [...incloseElements, ...outcloseElements].forEach(element => {
        element.style.filter = `hue-rotate(${hueRotate}deg) saturate(1) brightness(1)`;
    });
}

// Função para converter RGB para Hue
function rgbToHue(r, g, b) {
    r /= 255;
    g /= 255;
    b /= 255;
    
    const max = Math.max(r, g, b);
    const min = Math.min(r, g, b);
    const diff = max - min;
    
    let hue = 0;
    if (diff !== 0) {
        if (max === r) {
            hue = ((g - b) / diff) % 6;
        } else if (max === g) {
            hue = (b - r) / diff + 2;
        } else {
            hue = (r - g) / diff + 4;
        }
    }
    
    return hue * 60;
}