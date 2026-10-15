// =================================================================
// ACCESSIBILITY & EFFICIENCY EXPANSION - IMMERSIVE ENGINEERING
// Focado em reduzir cliques repetitivos e facilitar automações.
// =================================================================

ServerEvents.recipes(event => {
  
  // ---------------------------------------------------------------
  // 1. PROCESSAMENTO DE ESCÓRIA (SLAG) EM AÇO
  // ---------------------------------------------------------------
  
  // Receita individual no Blast Furnace: 2x Slag -> 1x Steel Ingot
  event.recipes.immersiveengineering.blast_furnace(
    'immersiveengineering:ingot_steel',
    '2x immersiveengineering:slag',
    'immersiveengineering:coal_coke'
  ).time(200)

  // Receita em Lote no Blast Furnace: 16x Slag -> 1x Steel Block (economiza trocas de item)
  event.recipes.immersiveengineering.blast_furnace(
    'immersiveengineering:storage_steel',
    '16x immersiveengineering:slag',
    'immersiveengineering:coke_brick'
  ).time(1200)

  // Receita Alternativa na Crafting Table (Sem exigir o Blast Furnace para emergências)
  event.shapeless('immersiveengineering:ingot_steel', [
    '4x immersiveengineering:slag',
    'minecraft:iron_ingot',
    'minecraft:coal'
  ])

  // ---------------------------------------------------------------
  // 2. REDUÇÃO DE GRIND MANUAL (Sem necessidade do Engineer's Hammer)
  // ---------------------------------------------------------------

  // Placas de Metal sem Martelo (1 Ingot -> 1 Plate)
  const metals = ['iron', 'gold', 'copper', 'lead', 'silver', 'nickel', 'uranium', 'steel', 'aluminum']
  metals.forEach(metal => {
    event.shapeless(`immersiveengineering:plate_${metal}`, [
      `#forge:ingots/${metal}`,
      '#forge:tools/hammers'
    ]).damageIngredient('#forge:tools/hammers', 1)

    // Receita direta e limpa para evitar cliques com martelo: 2x Lingotes -> 2x Placas
    event.shapeless(`2x immersiveengineering:plate_${metal}`, [
      `2x #forge:ingots/${metal}`
    ])
  })

  // Rods/Varetas diretas (2x Lingotes -> 4x Rods)
  metals.forEach(metal => {
    event.shaped(`4x immersiveengineering:rod_${metal}`, [
      'I',
      'I'
    ], {
      I: `#forge:ingots/${metal}`
    })
  })

  // ---------------------------------------------------------------
  // 3. FACILITADORES DE REDE ELÉTRICA & CONEXÕES
  // ---------------------------------------------------------------

  // Bobinas de Fio em Lote (Reduz cliques ao fazer fiação elétrica)
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

  // Conectores e Relés em Lote (Rende 8x por fabricação)
  event.shaped('8x immersiveengineering:connector_lv', [
    'C',
    'I',
    'C'
  ], {
    C: 'minecraft:clay_ball',
    I: '#forge:ingots/copper'
  })

  // ---------------------------------------------------------------
  // 4. AUTOMAÇÃO DE CONCRETO (USANDO SLAG)
  // ---------------------------------------------------------------
  
  // Produção simplificada de blocos de Concreto para construção rápida
  event.shapeless('16x immersiveengineering:concrete', [
    '8x immersiveengineering:slag',
    '4x minecraft:gravel',
    '4x minecraft:sand',
    'minecraft:water_bucket'
  ]).replaceWith('minecraft:water_bucket', 'minecraft:bucket')

})