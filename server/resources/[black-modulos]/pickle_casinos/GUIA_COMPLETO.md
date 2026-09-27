# 🎰 GUIA COMPLETO - PICKLE CASINOS

## 📖 O QUE É O PICKLE CASINOS?

O **Pickle Casinos** é um sistema de **cassinos pessoais/privados** para FiveM. Diferente de cassinos fixos no mapa, este sistema permite que **jogadores criem e gerenciem seus próprios cassinos** em qualquer lugar da cidade!

---

## 🎯 PARA QUE SERVEM OS ITENS?

### Os itens NÃO são para jogar diretamente!

Os itens são **mesas e máquinas físicas** que você coloca DENTRO do seu cassino:

| Item | Descrição |
|------|-----------|
| `blackjack_table` | Mesa física de Blackjack que você coloca no mundo |
| `baccarat_table` | Mesa física de Baccarat que você coloca no mundo |
| `roulette_table` | Mesa física de Roleta que você coloca no mundo |
| `poker_table` | Mesa física de Poker que você coloca no mundo |
| `wheel_machine` | Máquina de roda/spin que você coloca no mundo |
| `horseracing_machine` | Máquina de corrida de cavalos que você coloca no mundo |
| `slot_machine` | Máquina caça-níquel que você coloca no mundo |

---

## 🏗️ COMO FUNCIONA O SISTEMA?

### **PASSO 1: CRIAR UM CASSINO** (Apenas Admins)

1. Use o comando `/casino` (precisa ser Admin/Moderador/Nc)
2. Escolha uma localização
3. Configure:
   - Nome do cassino
   - Modelo de dealers (funcionários NPCs)
   - Loja de itens (comida/bebida)
   - Caixa para trocar dinheiro por fichas

### **PASSO 2: ADICIONAR MESAS E MÁQUINAS**

1. **Compre ou pegue** um dos itens (blackjack_table, roulette_table, etc)
2. **Use o item** do inventário (clique em "Usar")
3. O item abre um **modo de colocação**
4. **Posicione a mesa/máquina** onde quiser dentro do cassino
5. A mesa fica funcional no mundo!

### **PASSO 3: JOGAR**

1. Os jogadores chegam ao cassino
2. Vão até o **Caixa (Cashier)** e trocam dinheiro por **fichas do cassino**
3. Aproximam-se de uma **mesa/máquina que você colocou**
4. Interagem (E ou outro botão) para **jogar**!

---

## 🎮 JOGOS DISPONÍVEIS

### Jogos de Mesa (com dealer NPC):
- **Blackjack** - Jogo de cartas clássico
- **Baccarat** - Apostas em Player/Banker/Tie
- **Roulette** - Roleta com números e cores
- **Poker** - Texas Hold'em com outros jogadores

### Máquinas:
- **Wheel** - Roda da fortuna/spin
- **Horse Racing** - Corrida de cavalos
- **Slot Machine** - Caça-níqueis

---

## 💰 SISTEMA DE FICHAS

1. **Jogadores compram fichas** no caixa do cassino
2. **Usam fichas** para apostar nos jogos
3. Se **ganharem**, recebem mais fichas
4. **Trocam fichas de volta** por dinheiro no caixa

### O dono do cassino:
- Recebe uma % de todos os ganhos
- Pode sacar o lucro
- Gerencia preços e configurações

---

## 👨‍💼 COMANDOS E ACESSO

### Para Admins/Staff:
- `/casino` - Cria e gerencia cassinos
- `/mapobjects` - Escaneia mesas de cassino em MLOs

### Para Jogadores:
- **Usar item de mesa** - Coloca a mesa no mundo (se tiver permissão)
- **E (padrão)** - Interagir com mesas/caixa/loja
- **Esc** - Sair dos jogos

---

## 📍 ONDE USAR?

Você pode criar cassinos em:
- ✅ Propriedades/casas próprias
- ✅ Bases de organizações
- ✅ Locais alugados
- ✅ Qualquer interior acessível

---

## ⚙️ CONFIGURAÇÃO NA SUA BASE

### Quem pode criar cassinos?
Configurado em `Config.AdminGroups`:
```lua
Config.AdminGroups = {
    "Admin",
    "Nc", 
    "Administrador",
    "Moderador",
}
```

### Quem pode usar os itens de mesa?
Depende da **permissão do cassino**. O dono do cassino decide quem pode adicionar mesas.

---

## 🎯 EXEMPLO PRÁTICO

### Cenário: Você é dono de uma base criminal

1. **Admin cria um cassino** na sua base usando `/casino`
2. Você **transfere a propriedade** para sua organização
3. Você **compra 3 mesas** de blackjack (50k cada)
4. **Usa os itens** e posiciona as mesas na sala
5. **Contrata dealers** (NPCs automáticos)
6. **Abre o cassino** para membros
7. Eles **compram fichas** e **jogam**
8. Você **lucra** com cada aposta!

---

## ❓ PERGUNTAS FREQUENTES

**P: Preciso colocar a mesa todo dia?**  
R: Não! Uma vez colocada, a mesa fica salva no banco de dados.

**P: Posso remover uma mesa depois?**  
R: Sim, através do menu de gerenciamento do cassino.

**P: Os jogos são justos?**  
R: Sim, usam RNG (Random Number Generator) configurável.

**P: Onde estão as imagens dos itens?**  
R: Devem estar em `resources/[system]/vrp/black_inventory/` com os nomes:
- `blackjack_table.png`
- `roulette_table.png`
- etc.

---

## 🔧 SUPORTE TÉCNICO

Se as mesas não aparecerem:
1. Verifique se adicionou as **imagens PNG** dos itens
2. Certifique-se que o script está **iniciado** (`ensure pickle_casinos`)
3. Confira se é **Admin** para usar `/casino`
4. Veja o console F8 para erros

---

**Sistema desenvolvido por:** Pickle Mods  
**Adaptado para:** VRP BlackNetwork

