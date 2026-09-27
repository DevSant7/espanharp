Para melhor visualização clique com o botão direito > Abrir Preview

## Requisições (Front-end > Back-end):

### Setar a visibilidade da interface:

<span style="color: lightyellow; font-size: 1.2rem;margin-left: 1.4rem">endpoint: <strong>setVisible</strong></span>

- **Parâmetros**:
  ```lua
  { "visible": true }
  { "visible": false }
  ```

### Enviar as informações da safezone:

<span style="color: lightyellow; font-size: 1.2rem;margin-left: 1.4rem">endpoint: <strong>safezone</strong></span>

- **Parâmetros**:
  ```lua
  { "data": true }
  ```

### Enviar as informações das notificações:

<span style="color: lightyellow; font-size: 1.2rem;margin-left: 1.4rem">endpoint: <strong>notification</strong></span>

- **Parâmetros**:
  ```lua
  {
      "type": "admin",
      "title": "Cidade Informa:",
      "message":
        "Nosso cupom “PASCOA50” está disponível em nosso website de compras, utilize agora para ganhar 50% de desconto em qualquer compra.",
      "author": "Prefeitura",
      "time": 5000,
  }
  ```

### Enviar as informações dos anúncios:

<span style="color: lightyellow; font-size: 1.2rem;margin-left: 1.4rem">endpoint: <strong>announcement</strong></span>

- **Parâmetros**:
  ```lua
  {
      "type": "warning",
      "title": "Comunicado",
      "message":
        "Reinício programado da cidade em 10 minutos. Evite perder itens.",
      "time": 5000,
  }
  ```

### Enviar as informações do armamento:

<span style="color: lightyellow; font-size: 1.2rem;margin-left: 1.4rem">endpoint: <strong>weapon</strong></span>

- **Parâmetros**:

  ```lua
  {
      "visible": true,
      "weapon": {
        "name": "Carabina de precisão",
        "ammo": 24,
        "inClip": 233,
      },
  }
  ```

### Enviar as informações do veículo:

<span style="color: lightyellow; font-size: 1.2rem;margin-left: 1.4rem">endpoint: <strong>vehicle</strong></span>

- **Parâmetros**:
  ```lua
  {
      "show": true,
      "locked": false,
      "seatbelt": false,
      "fuel": 60,
      "speed": 80,
      "gear": 4,
  }
  ```

### Enviar as informações do player:

<span style="color: lightyellow; font-size: 1.2rem;margin-left: 1.4rem">endpoint: <strong>player</strong></span>

- **Parâmetros**:
  ```lua
  {
      "health": 50,
      "shield": 40,
      "hunger": 0,
      "thirst": 100,
  }
  ```

### Enviar as informações do topo:

<span style="color: lightyellow; font-size: 1.2rem;margin-left: 1.4rem">endpoint: <strong>infos</strong></span>

- **Parâmetros**:
  ```lua
  {
      "mic": 2,
      "talking": false,
      "frequency": 222,
      "diamonds": 25000,
      "playerId": 1024,
  }
  ```

### Fechar a interface:

<span style="color: lightyellow; font-size: 1.2rem;margin-left: 1.4rem">endpoint: <strong>hideFrame</strong></span>

- **Método**: POST
- **Parâmetros**:

  ```lua

  ```

- **Resposta**:

  ```lua

  ```
