// =================================================================
// ACCESSIBILITY & EFFICIENCY EXPANSION - IMMERSIVE ENGINEERING
// Focado no REAPROVEITAMENTO DIRETO DE SLAG para AÇO e acessibilidade.
// =================================================================

ServerEvents.recipes(event => {
  
  // ---------------------------------------------------------------
  // 1. REAPROVEITAMENTO DIRETO DE SLAG (ESCÓRIA) EM AÇO
  // (Sem necessidade de adicionar Iron Ingot)
  // ---------------------------------------------------------------
  
  // Receita direta no Blast Furnace: 4x Slag -> 1x Steel Ingot
  event.recipes.immersiveengineering.blast_furnace(
    'immersiveengineering:ingot_steel',
    '4x immersiveengineering:slag',
    'immersiveengineering:coal_coke'
  ).time(200)

  // Receita em Lote no Blast Furnace: 36x Slag -> 1x Steel Block (Economiza abastecimento)
  event.recipes.immersiveengineering.blast_furnace(
    'immersiveengineering:storage_steel',
    '36x immersiveengineering:slag',
    'immersiveengineering:coke_brick'
  ).time(1200)

  // Reciclagem de Slag na Crafting Table (Purificação simples: Slag + Carvão = Aço)
  event.shapeless('immersiveengineering:ingot_steel', [
    '4x immersiveengineering:slag',
    'minecraft:coal'
  ])

  // Reciclagem Expressa de Slag na Crafting Table (4x Slag + 1x Coal Coke -> 2x Steel Ingot)
  event.shapeless('2x immersiveengineering:ingot_steel', [
    '4x immersiveengineering:slag',
    'immersiveengineering:coal_coke'
  ])

  // ---------------------------------------------------------------
  // 2. REDUÇÃO DE GRIND MANUAL (Facilitadores sem Martelo)
  // ---------------------------------------------------------------

  // Placas de Metal Diretas (2x Lingotes -> 2x Placas, sem precisar usar o Hammer)
  const metals = ['iron', 'gold', 'copper', 'lead', 'silver', 'nickel', 'uranium', 'steel', 'aluminum']
  metals.forEach(metal => {
    event.shapeless(`2x immersiveengineering:plate_${metal}`, [
      `2x #forge:ingots/${metal}`
    ])
  })

  // Rods/Varetas Diretas (2x Lingotes -> 4x Rods)
  metals.forEach(metal => {
    event.shaped(`4x immersiveengineering:rod_${metal}`, [
      'I',
      'I'
    ], {
      I: `#forge:ingots/${metal}`
    })
  })

  // ---------------------------------------------------------------
  // 3. FACILITADORES DE FIAÇÃO E CONEXÕES ELÉTRICAS (Lote Grande)
  // ---------------------------------------------------------------

  // Bobinas de Fio em Lote
  event.shaped('8x immersiveengineering:wirecoil_copper', [
    ' W ',
    'WSW',
    ' W '
  ], {
    W: '#forge:wires/copper',
    S: 'minecraft:stick'
  })

  event.shaped('8x immersiveengineering:wirecoil_electrum', [
    ' W ',
    'WSW',
    ' W '
  ], {
    W: '#forge:wires/electrum',
    S: 'minecraft:stick'
  })

  event.shaped('8x immersiveengineering:wirecoil_steel', [
    ' W ',
    'WSW',
    ' W '
  ], {
    W: '#forge:wires/steel',
    S: 'minecraft:stick'
  })

  // Conectores de Energia (Rende 8x por fabricação)
  event.shaped('8x immersiveengineering:connector_lv', [
    'C',
    'I',
    'C'
  ], {
    C: 'minecraft:clay_ball',
    I: '#forge:ingots/copper'
  })

  // ---------------------------------------------------------------
  // 4. USO SECUNDÁRIO DO SLAG (CONCRETO EM LOTE)
  // ---------------------------------------------------------------
  
  // Produção em massa de Concreto reaproveitando Slag
  event.shapeless('16x immersiveengineering:concrete', [
    '8x immersiveengineering:slag',
    '4x minecraft:gravel',
    '4x minecraft:sand',
    'minecraft:water_bucket'
  ]).replaceWith('minecraft:water_bucket', 'minecraft:bucket')

})
