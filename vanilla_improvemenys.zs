#priority 100
// ==========================================
// VANILLA QOL & LOGICAL RECIPES (CraftTweaker 1.12.2)
// ==========================================

import crafttweaker.item.IItemStack;

// ------------------------------------------
// 1. RECURSOS BÁSICOS & CONVERSÕES LÓGICAS
// ------------------------------------------

// 3 Cascalhos (Gravel) -> 1 Pederneira (Flint)
recipes.addShapeless("gravel_to_flint", <minecraft:flint>, [
    <minecraft:gravel>, <minecraft:gravel>, <minecraft:gravel>
]);

// 4 Pederneiras (Flint) -> 1 Pedra (Stone)
recipes.addShaped("flint_to_stone", <minecraft:stone>, [
    [<minecraft:flint>, <minecraft:flint>],
    [<minecraft:flint>, <minecraft:flint>]
]);

// 4 Teias de Aranha (Cobweb) -> 1 Lã Branca
recipes.addShapeless("cobweb_to_wool", <minecraft:wool>, [
    <minecraft:web>, <minecraft:web>, <minecraft:web>, <minecraft:web>
]);

// 1 Bloco de Quartzo -> 4 Quartzo do Nether
recipes.addShapeless("quartz_block_to_items", <minecraft:quartz> * 4, [
    <minecraft:quartz_block>
]);

// 1 Bloco de Tijolos -> 4 Tijolos
recipes.addShapeless("brick_block_to_items", <minecraft:brick> * 4, [
    <minecraft:brick_block>
]);

// 1 Bloco de Magma -> 4 Magma Cream
recipes.addShapeless("magma_block_to_cream", <minecraft:magma_cream> * 4, [
    <minecraft:magma>
]);

// ------------------------------------------
// 2. DESFACILITANDO RECRAFTING (Uncrafting)
// ------------------------------------------

// 1 Cela (Saddle) -> 3 Couros + 1 Lingote de Ferro
recipes.addShapeless("saddle_to_resources", <minecraft:leather> * 3, [
    <minecraft:saddle>
]);

// Reciclar Armaduras de Cavalo (Horse Armor)
recipes.addShapeless("iron_horse_armor_deconstruct", <minecraft:iron_ingot> * 4, [
    <minecraft:iron_horse_armor>
]);
recipes.addShapeless("gold_horse_armor_deconstruct", <minecraft:gold_ingot> * 4, [
    <minecraft:golden_horse_armor>
]);
recipes.addShapeless("diamond_horse_armor_deconstruct", <minecraft:diamond> * 4, [
    <minecraft:diamond_horse_armor>
]);

// Reciclar Trilhos em Lingotes de Ferro
recipes.addShapeless("rails_to_iron", <minecraft:iron_ingot> * 3, [
    <minecraft:rail>, <minecraft:rail>, <minecraft:rail>, 
    <minecraft:rail>, <minecraft:rail>, <minecraft:rail>
]);

// ------------------------------------------
// 3. RECIPES DE UTENSÍLIOS E UTILITÁRIOS
// ------------------------------------------

// Craft de Teia de Aranha (Cobweb) usando Linhas
recipes.addShaped("craft_cobweb", <minecraft:web>, [
    [<minecraft:string>, <minecraft:string>, <minecraft:string>],
    [<minecraft:string>, <minecraft:string>, <minecraft:string>],
    [<minecraft:string>, <minecraft:string>, <minecraft:string>]
]);

// Craft de Cela (Saddle)
recipes.addShaped("craft_saddle", <minecraft:saddle>, [
    [<minecraft:leather>, <minecraft:leather>, <minecraft:leather>],
    [<minecraft:string>, <minecraft:iron_ingot>, <minecraft:string>],
    [null, null, null]
]);

// Craft de Name Tag (Etiqueta)
recipes.addShaped("craft_nametag", <minecraft:name_tag>, [
    [null, <minecraft:paper>, <minecraft:string>],
    [<minecraft:paper>, <minecraft:dye:0>, <minecraft:paper>],
    [<minecraft:paper>, <minecraft:paper>, null]
]);

// Craft de Disco de Música aleatório / básico
recipes.addShaped("craft_music_disc", <minecraft:record_13>, [
    [<minecraft:obsidian>, <minecraft:obsidian>, <minecraft:obsidian>],
    [<minecraft:obsidian>, <minecraft:redstone>, <minecraft:obsidian>],
    [<minecraft:obsidian>, <minecraft:obsidian>, <minecraft:obsidian>]
]);

// ------------------------------------------
// 4. MADEIRAS E PLANTAS
// ------------------------------------------

// 2 Gravetos + 1 Maçã -> Maçã do Amor / Sustento
recipes.addShapeless("stick_sapling_conversion", <minecraft:sapling> * 2, [
    <minecraft:leaves>, <minecraft:stick>
]);

// Converter qualquer muda de árvore em Madeira/Carvão Vegetal (Smelting extra)
furnace.addRecipe(<minecraft:coal:1>, <minecraft:sapling> * 4);

// ==========================================
// EASY BLAZE ROD RECIPES (Acessibilidade)
// ==========================================

// 1. Receita na Bancada: 1 Graveto + 1 Bloco de Magma + 2 Pós de Redstone = 1 Blaze Rod
recipes.addShaped("easy_blaze_rod_craft", <minecraft:blaze_rod>, [
    [null, <minecraft:redstone>, null],
    [<minecraft:redstone>, <minecraft:magma>, null],
    [null, null, <minecraft:stick>]
]);

// 2. Receita com Lava: 1 Graveto + 1 Balde de Lava + 1 Carvão = 2 Blaze Rods
recipes.addShaped("easy_blaze_rod_lava", <minecraft:blaze_rod> * 2, [
    [null, <minecraft:coal>, null],
    [null, <minecraft:lava_bucket>, null],
    [null, <minecraft:stick>, null]
]);

// 3. Obter Blaze Powder assando Pederneira/Cacto com Redstone na Fornalha
furnace.addRecipe(<minecraft:blaze_powder> * 2, <minecraft:magma_cream>);

// ==========================================
// 1. DROPS DE MOBS HOSTIS (Sem combate/caça)
// ==========================================

// Lágrima de Ghast (Ghast Tear): 1 Frasco de Água + 1 Quartzo + 1 Açúcar
recipes.addShapeless("easy_ghast_tear", <minecraft:ghast_tear>, [
    <minecraft:potion>.withTag({Potion: "minecraft:water"}), 
    <minecraft:quartz>, 
    <minecraft:sugar>
]);

// Pérola do Fim (Ender Pearl): 1 Bloco de Slime + 1 Carvão + 1 Pederneira
recipes.addShaped("easy_ender_pearl", <minecraft:ender_pearl> * 2, [
    [<minecraft:coal>, <minecraft:slime_ball>, null],
    [<minecraft:slime_ball>, <minecraft:flint>, null],
    [null, null, null]
]);

// Pó de Blaze extra: 1 Carvão + 1 Pólvora + 1 Redstone
recipes.addShapeless("easy_blaze_powder_alt", <minecraft:blaze_powder> * 2, [
    <minecraft:coal>, <minecraft:gunpowder>, <minecraft:redstone>
]);

// Pólvora (Gunpowder): 1 Carvão + 1 Redstone + 1 Areia
recipes.addShapeless("easy_gunpowder", <minecraft:gunpowder> * 2, [
    <minecraft:coal>, <minecraft:redstone>, <minecraft:sand>
]);

// Olho de Aranha (Spider Eye): 1 Cogumelo Marrom + 1 Açúcar + 1 Carne Podre
recipes.addShapeless("easy_spider_eye", <minecraft:spider_eye>, [
    <minecraft:brown_mushroom>, <minecraft:sugar>, <minecraft:rotten_flesh>
]);

// Cabeça de Wither Skeleton: 1 Esqueleto Skull + 4 Carvões
recipes.addShapeless("easy_wither_skull", <minecraft:skull:1>, [
    <minecraft:skull:0>, <minecraft:coal>, <minecraft:coal>, <minecraft:coal>, <minecraft:coal>
]);


// ==========================================
// 2. RECURSOS DO NETHER NO OVERWORLD
// ==========================================

// Netherrack: 1 Pedra + 1 Balde de Lava
recipes.addShaped("easy_netherrack", <minecraft:netherrack> * 8, [
    [<minecraft:stone>, <minecraft:stone>, <minecraft:stone>],
    [<minecraft:stone>, <minecraft:lava_bucket>, <minecraft:stone>],
    [<minecraft:stone>, <minecraft:stone>, <minecraft:stone>]
]);

// Areia das Almas (Soul Sand): 1 Areia + 1 Carvão + 1 Carne Podre
recipes.addShapeless("easy_soul_sand", <minecraft:soul_sand> * 2, [
    <minecraft:sand>, <minecraft:coal>, <minecraft:rotten_flesh>
]);

// Pedra-Luz (Glowstone Block): 1 Bloco de Redstone + 1 Barra de Ouro
recipes.addShapeless("easy_glowstone_block", <minecraft:glowstone>, [
    <minecraft:redstone_block>, <minecraft:gold_ingot>
]);


// ==========================================
// 3. MINÉRIOS & MATERIAIS RAROS
// ==========================================

// Diamante sintético: 4 Blocos de Carvão comprimidos com 1 Ferro
recipes.addShaped("easy_diamond", <minecraft:diamond>, [
    [<minecraft:coal_block>, <minecraft:coal_block>, null],
    [<minecraft:coal_block>, <minecraft:coal_block>, null],
    [null, null, <minecraft:iron_ingot>]
]);

// Esmeralda: 1 Diamante + 4 Sementes (Qualquer)
recipes.addShapeless("easy_emerald", <minecraft:emerald>, [
    <minecraft:diamond>, <minecraft:wheat_seeds>, <minecraft:wheat_seeds>, <minecraft:wheat_seeds>, <minecraft:wheat_seeds>
]);

// Lapiz Lazúli: 1 Corante Azul / Mirtilo + 1 Pedra
recipes.addShapeless("easy_lapis", <minecraft:dye:4> * 4, [
    <minecraft:stone>, <minecraft:blue_glazed_terracotta>
]);


// ==========================================
// 4. PLANTAS, FLORES E COMIDA
// ==========================================

// Maçã Dourada (Golden Apple): Usa Lingotes de Ouro em vez de Blocos
recipes.addShaped("easy_golden_apple", <minecraft:golden_apple>, [
    [<minecraft:gold_ingot>, <minecraft:gold_ingot>, <minecraft:gold_ingot>],
    [<minecraft:gold_ingot>, <minecraft:apple>, <minecraft:gold_ingot>],
    [<minecraft:gold_ingot>, <minecraft:gold_ingot>, <minecraft:gold_ingot>]
]);

// Transformar Madeira em Maçãs (1 Tronco + 1 Graveto)
recipes.addShapeless("easy_apple_craft", <minecraft:apple> * 2, [
    <minecraft:log>, <minecraft:stick>
]);

// Fungo do Nether (Nether Wart): 1 Cogumelo Vermelho + 1 Açúcar
recipes.addShapeless("easy_nether_wart", <minecraft:nether_wart> * 2, [
    <minecraft:red_mushroom>, <minecraft:sugar>
]);

// Cacau (Cocoa Beans): 1 Semente de Trigo + 1 Carvão Vegetal
recipes.addShapeless("easy_cocoa_beans", <minecraft:dye:3> * 3, [
    <minecraft:wheat_seeds>, <minecraft:coal:1>
]);

#priority 100
// =================================================================
// MEGA PACK: ACESSIBILIDADE, QOL E UTILITIES (CraftTweaker 1.12.2)
// =================================================================


// -----------------------------------------------------------------
// 1. UTILITÁRIOS DE MOBS & ITENS RAROS (End, Monumentos e Mobs)
// -----------------------------------------------------------------

// Shulker Shell: 4 Púrpuras + 1 Pérola do Fim
recipes.addShaped("easy_shulker_shell", <minecraft:shulker_shell>, [
    [<minecraft:purpur_block>, <minecraft:purpur_block>, null],
    [<minecraft:ender_pearl>, <minecraft:purpur_block>, null],
    [null, null, null]
]);

// Elytra: 4 Couros + 2 Penas + 2 Linhas + 1 Pérola do Fim
recipes.addShaped("easy_elytra", <minecraft:elytra>, [
    [<minecraft:leather>, <minecraft:ender_pearl>, <minecraft:leather>],
    [<minecraft:feather>, <minecraft:string>, <minecraft:feather>],
    [<minecraft:leather>, null, <minecraft:leather>]
]);

// Totem da Imortalidade (Totem of Undying): 1 Esmeralda + 2 Blocos de Ouro + 1 Maçã Dourada
recipes.addShapeless("easy_totem", <minecraft:totem_of_undying>, [
    <minecraft:emerald>, <minecraft:gold_block>, <minecraft:gold_block>, <minecraft:golden_apple>
]);

// Esponja (Sponge): 4 Lãs Amarelas + 1 Balde de Água
recipes.addShaped("easy_sponge", <minecraft:sponge>, [
    [<minecraft:wool:4>, <minecraft:wool:4>, null],
    [<minecraft:water_bucket>, <minecraft:wool:4>, null],
    [<minecraft:wool:4>, null, null]
]);

// Fragmento de Prismarino (Prismarine Shard): 1 Lapiz Lazúli + 1 Quartzo + 1 Pedra
recipes.addShapeless("easy_prismarine_shard", <minecraft:prismarine_shard> * 2, [
    <minecraft:dye:4>, <minecraft:quartz>, <minecraft:stone>
]);

// Cristal de Prismarino (Prismarine Crystals): 1 Fragmento + 1 Glowstone Dust
recipes.addShapeless("easy_prismarine_crystals", <minecraft:prismarine_crystals> * 2, [
    <minecraft:prismarine_shard>, <minecraft:glowstone_dust>
]);

// Bafo de Dragão (Dragon's Breath): 1 Frasco de Vidro + 1 Blaze Powder + 1 Redstone
recipes.addShapeless("easy_dragons_breath", <minecraft:dragon_breath>, [
    <minecraft:glass_bottle>, <minecraft:blaze_powder>, <minecraft:redstone>
]);

// Frasco de Experiência (Bottle o' Enchanting): 1 Frasco de Vidro + 1 Lapiz Lazúli + 1 Lingote de Ouro
recipes.addShapeless("easy_xp_bottle", <minecraft:experience_bottle> * 3, [
    <minecraft:glass_bottle>, <minecraft:dye:4>, <minecraft:gold_ingot>
]);

// Bola de Slime (Slimeball) Direta: 1 Corante Verde + 1 Açúcar + 1 Balde de Água
recipes.addShapeless("easy_slimeball", <minecraft:slime_ball> * 2, [
    <minecraft:dye:2>, <minecraft:sugar>, <minecraft:water_bucket>
]);

// Laço (Lead) Simplificado Sem Posição Fixa
recipes.addShapeless("easy_lead_shapeless", <minecraft:lead>, [
    <minecraft:string>, <minecraft:string>, <minecraft:string>, <minecraft:string>, <minecraft:slime_ball>
]);


// -----------------------------------------------------------------
// 2. RECICLAGEM E DESCONSTRUÇÃO (Uncrafting)
// -----------------------------------------------------------------

// Bigorna (Anvil) -> 31 Lingotes de Ferro
recipes.addShapeless("uncraft_anvil", <minecraft:iron_ingot> * 31, [
    <minecraft:anvil>
]);

// Carrinho de Mina (Minecart) -> 5 Lingotes de Ferro
recipes.addShapeless("uncraft_minecart", <minecraft:iron_ingot> * 5, [
    <minecraft:minecart>
]);

// Caldeirão (Cauldron) -> 7 Lingotes de Ferro
recipes.addShapeless("uncraft_cauldron", <minecraft:iron_ingot> * 7, [
    <minecraft:cauldron>
]);

// Balde (Bucket) -> 3 Lingotes de Ferro
recipes.addShapeless("uncraft_bucket", <minecraft:iron_ingot> * 3, [
    <minecraft:bucket>
]);

// Tesoura (Shears) -> 2 Lingotes de Ferro
recipes.addShapeless("uncraft_shears", <minecraft:iron_ingot> * 2, [
    <minecraft:shears>
]);


// -----------------------------------------------------------------
// 3. BLOCOS DE CONSTRUÇÃO E NATUREZA
// -----------------------------------------------------------------

// Argila (Clay Block): 1 Terra + 1 Areia + 1 Balde de Água
recipes.addShapeless("easy_clay_block", <minecraft:clay> * 2, [
    <minecraft:dirt>, <minecraft:sand>, <minecraft:water_bucket>
]);

// Pedra do Fim (End Stone): 1 Cobblestone + 1 Pérola do Fim
recipes.addShapeless("easy_end_stone", <minecraft:end_stone> * 4, [
    <minecraft:cobblestone>, <minecraft:cobblestone>, <minecraft:cobblestone>, <minecraft:cobblestone>, <minecraft:ender_pearl>
]);

// Gelo Compactado (Packed Ice): 4 Gelos Normais
recipes.addShaped("easy_packed_ice", <minecraft:packed_ice>, [
    [<minecraft:ice>, <minecraft:ice>],
    [<minecraft:ice>, <minecraft:ice>]
]);

// Vitória-Régia (Lily Pad): 3 Folhas de Árvore
recipes.addShapeless("easy_lily_pad", <minecraft:waterlily> * 2, [
    <minecraft:leaves>, <minecraft:leaves>, <minecraft:leaves>
]);

// Trepadeira (Vines): 2 Gravetos + 2 Folhas
recipes.addShapeless("easy_vines", <minecraft:vine> * 3, [
    <minecraft:stick>, <minecraft:leaves>
]);


// -----------------------------------------------------------------
// 4. ALIMENTOS E AGRICULTURA
// -----------------------------------------------------------------

// Maçã do Notched (Enchanted Golden Apple): 1 Maçã Dourada + 8 Blocos de Ouro
recipes.addShaped("easy_notch_apple", <minecraft:golden_apple:1>, [
    [<minecraft:gold_block>, <minecraft:gold_block>, <minecraft:gold_block>],
    [<minecraft:gold_block>, <minecraft:golden_apple>, <minecraft:gold_block>],
    [<minecraft:gold_block>, <minecraft:gold_block>, <minecraft:gold_block>]
]);

// Fruta do Coro (Chorus Fruit): 1 Maçã + 1 Pérola do Fim
recipes.addShapeless("easy_chorus_fruit", <minecraft:chorus_fruit> * 2, [
    <minecraft:apple>, <minecraft:ender_pearl>
]);

// Sementes de Melancia
recipes.addShapeless("easy_melon_seeds", <minecraft:melon_seeds> * 2, [
    <minecraft:wheat_seeds>, <minecraft:dye:2>
]);

// ==========================================
// RENOVAÇÃO E CRIAÇÃO DE LAVA (1.12.2)
// ==========================================

// 1. Derreter Bloco de Magma na Fornalha -> Gera 1 Balde de Lava
furnace.addRecipe(<minecraft:lava_bucket>, <minecraft:magma>);

// 2. Derreter Pedras com Carvão na Workbench (Simulação de derretimento):
// 1 Balde Vazio + 4 Pedras (Cobblestone) + 1 Carvão = 1 Balde de Lava
recipes.addShaped("easy_lava_craft", <minecraft:lava_bucket>, [
    [<minecraft:cobblestone>, <minecraft:cobblestone>, null],
    [<minecraft:cobblestone>, <minecraft:bucket>, null],
    [null, <minecraft:coal>, null]
]);

// ==========================================
// MÓDULO NETHER COMPLETO (Acessibilidade)
// ==========================================

// Minério de Quartzo
recipes.addShaped("easy_quartz_ore", <minecraft:quartz_ore> * 2, [
    [<minecraft:cobblestone>, <minecraft:stone:3>, null],
    [<minecraft:redstone>, <minecraft:cobblestone>, null],
    [null, null, null]
]);

// Quartzo direto
recipes.addShapeless("easy_nether_quartz_direct", <minecraft:quartz> * 2, [
    <minecraft:stone:3>, <minecraft:redstone>
]);

// 2. Tijolo do Nether (Nether Brick Item)
// 1 Argila + 1 Carvão + 1 Redstone
recipes.addShapeless("easy_nether_brick_item", <minecraft:netherbrick> * 2, [
    <minecraft:clay_ball>, <minecraft:coal>, <minecraft:redstone>
]);

// Bloco de Tijolos do Nether (Nether Brick Block)
recipes.addShaped("easy_nether_brick_block", <minecraft:nether_brick>, [
    [<minecraft:netherbrick>, <minecraft:netherbrick>],
    [<minecraft:netherbrick>, <minecraft:netherbrick>]
]);

// 3. Bloco de Magma & Magma Cream
recipes.addShapeless("easy_magma_block_craft", <minecraft:magma> * 2, [
    <minecraft:netherrack>, <minecraft:redstone>, <minecraft:coal>
]);

recipes.addShapeless("easy_magma_cream_craft", <minecraft:magma_cream> * 2, [
    <minecraft:slime_ball>, <minecraft:redstone>
]);

// 4. Fungo do Nether (Nether Wart)
// 1 Cogumelo Vermelho + 1 Açúcar
recipes.addShapeless("easy_nether_wart_craft", <minecraft:nether_wart> * 2, [
    <minecraft:red_mushroom>, <minecraft:sugar>
]);

// 5. Pó de Glowstone (Glowstone Dust)
// 1 Redstone + 1 Pepita de Ouro
recipes.addShapeless("easy_glowstone_dust", <minecraft:glowstone_dust> * 2, [
    <minecraft:redstone>, <minecraft:gold_nugget>
]);

// 6. Estrela do Nether (Nether Star - Para Beacons)
// 1 Bloco de Diamante + 4 Frascos de XP + 4 Blocos de Ouro
recipes.addShaped("easy_nether_star", <minecraft:nether_star>, [
    [<minecraft:gold_block>, <minecraft:experience_bottle>, <minecraft:gold_block>],
    [<minecraft:experience_bottle>, <minecraft:diamond_block>, <minecraft:experience_bottle>],
    [<minecraft:gold_block>, <minecraft:experience_bottle>, <minecraft:gold_block>]
]);

// 7. Cogumelo Vermelho / Marrom (Para fazer Poções e Fungos)
recipes.addShapeless("easy_red_mushroom", <minecraft:red_mushroom> * 2, [
    <minecraft:wheat_seeds>, <minecraft:apple>
]);
recipes.addShapeless("easy_brown_mushroom", <minecraft:brown_mushroom> * 2, [
    <minecraft:wheat_seeds>, <minecraft:dirt>
]);

// ==========================================
// MÓDULO THE END COMPLETO (Isolamento Total)
// ==========================================

// 1. Flor do Coro (Chorus Flower)
// Permite plantar/cultivar Chorus na sua base sem explorar as ilhas
recipes.addShapeless("easy_chorus_flower", <minecraft:chorus_flower>, [
    <minecraft:chorus_fruit>, <minecraft:end_stone>, <minecraft:dye:5>
]);

// Fruta do Coro Estourada (Popped Chorus Fruit)
recipes.addShapeless("easy_popped_chorus", <minecraft:chorus_fruit_popped> * 2, [
    <minecraft:chorus_fruit>, <minecraft:coal>
]);

// 2. Blocos de Purpur (Purpur Block)
// 4 Pedras do Fim + 1 Corante Roxo = 4 Blocos de Purpur
recipes.addShaped("easy_purpur_block_alt", <minecraft:purpur_block> * 4, [
    [<minecraft:end_stone>, <minecraft:end_stone>],
    [<minecraft:end_stone>, <minecraft:dye:5>]
]);

// 3. Vara do Fim (End Rod - Excelente para Iluminação)
// 1 Vara de Blaze + 1 Quartzo do Nether = 4 Varas do Fim
recipes.addShaped("easy_end_rod", <minecraft:end_rod> * 4, [
    [<minecraft:quartz>],
    [<minecraft:blaze_rod>]
]);

// 4. Tijolos de Pedra do Fim (End Stone Bricks)
recipes.addShaped("easy_end_bricks", <minecraft:end_bricks> * 4, [
    [<minecraft:end_stone>, <minecraft:end_stone>],
    [<minecraft:end_stone>, <minecraft:end_stone>]
]);

// 5. Cabeça de Dragão (Dragon Head)
// 1 Crânio de Esqueleto + 1 Bafo de Dragão + 1 Obsidiana
recipes.addShapeless("easy_dragon_head", <minecraft:skull:5>, [
    <minecraft:skull:0>, <minecraft:dragon_breath>, <minecraft:obsidian>
]);

// 6. Ovo de Dragão (Dragon Egg - Troféu)
// 1 Obsidiana + 4 Pedras do Fim + 4 Pérolas do Fim
recipes.addShaped("easy_dragon_egg", <minecraft:dragon_egg>, [
    [<minecraft:end_stone>, <minecraft:ender_pearl>, <minecraft:end_stone>],
    [<minecraft:ender_pearl>, <minecraft:obsidian>, <minecraft:ender_pearl>],
    [<minecraft:end_stone>, <minecraft:ender_pearl>, <minecraft:end_stone>]
]);

// 7. Moldura do Portal do Fim (End Portal Frame)
// Permite construir a estrutura do portal na sua própria base se quiser usar como decoração ou atalho
recipes.addShaped("easy_end_portal_frame", <minecraft:end_portal_frame>, [
    [<minecraft:end_stone>, <minecraft:ender_eye>, <minecraft:end_stone>],
    [<minecraft:obsidian>, <minecraft:obsidian>, <minecraft:obsidian>],
    [null, null, null]
]);

// Receita para o Creative Vending Upgrade (Storage Drawers)
recipes.addShaped("easy_creative_vending", <storagedrawers:upgrade_creative>, [
    [<minecraft:diamond_block>, <minecraft:emerald_block>, <minecraft:diamond_block>],
    [<minecraft:gold_block>, <minecraft:chest>, <minecraft:gold_block>],
    [<minecraft:obsidian>, <minecraft:redstone_block>, <minecraft:obsidian>]
]);
