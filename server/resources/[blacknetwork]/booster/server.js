const express = require('express');
const app = express();

app.use(express.json());

app.post('/booster', async (req, res) => {
  const { playerId, action } = req.body;

  try {
    emit("limirio:trySetBooster",playerId,action)

    res.status(200).send('Evento executado com sucesso');
  } catch (err) {

    console.error(err.message);
    res.status(500).send('Erro ao executar evento');
  }
});

app.listen(3000, () => {
  console.log('API rodando na porta 3000');
});
