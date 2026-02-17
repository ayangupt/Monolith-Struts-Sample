INSERT INTO roles(id, name) VALUES
  ('r-admin', 'ADMIN'),
  ('r-user', 'USER');

INSERT INTO users(id, email, username, password_hash, salt, status, role, created_at, updated_at) VALUES
  ('u-1', 'user@example.com', 'demo', 'hash', 'salt', 'ACTIVE', 'USER', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);

INSERT INTO categories(id, name, parent_id) VALUES
  ('c-1', 'Ski', NULL);

-- Additional categories
INSERT INTO categories(id, name, parent_id) VALUES
  ('c-boots', 'Boots', NULL),
  ('c-wear', 'Wear', NULL),
  ('c-helmet', 'Helmet', NULL),
  ('c-glove', 'Glove', NULL),
  ('c-pole', 'Pole', NULL),
  ('c-wax', 'Wax', NULL);

INSERT INTO products(id, name, brand, description, category_id, sku, status, created_at, updated_at) VALUES
  ('P001', 'Ski A', 'BrandX', 'Entry ski', 'c-1', 'SKU-001', 'ACTIVE', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);

-- Sample products (20 each per category)
INSERT INTO products(id, name, brand, description, category_id, sku, status, created_at, updated_at) VALUES
  -- Skis (c-1)
  ('PSK001', 'Atomic Redster G9 [Advanced Men]', 'Atomic', 'Advanced men - high-speed carving', 'c-1', 'SKI-001', 'ACTIVE', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
  ('PSK002', 'Head Supershape e-Speed [Advanced Men]', 'Head', 'Advanced on-piste racing', 'c-1', 'SKI-002', 'ACTIVE', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
  ('PSK003', 'Salomon S/Max 12 [Advanced Women]', 'Salomon', 'Advanced women carving', 'c-1', 'SKI-003', 'ACTIVE', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
  ('PSK004', 'Rossignol Experience 86 [Intermediate Men]', 'Rossignol', 'Intermediate men all-mountain', 'c-1', 'SKI-004', 'ACTIVE', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
  ('PSK005', 'Rossignol Nova 8 [Intermediate Women]', 'Rossignol', 'Intermediate women all-mountain', 'c-1', 'SKI-005', 'ACTIVE', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
  ('PSK006', 'Fischer RC4 The Curv [Advanced Men]', 'Fischer', 'Advanced men racing', 'c-1', 'SKI-006', 'ACTIVE', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
  ('PSK007', 'Fischer My Curv [Advanced Women]', 'Fischer', 'Advanced women racing', 'c-1', 'SKI-007', 'ACTIVE', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
  ('PSK008', 'K2 Mindbender 90C [Intermediate Women]', 'K2', 'Intermediate women freeride', 'c-1', 'SKI-008', 'ACTIVE', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
  ('PSK009', 'K2 Disruption 78C [Beginner Men]', 'K2', 'Beginner men on-piste', 'c-1', 'SKI-009', 'ACTIVE', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
  ('PSK010', 'Nordica Enforcer 94 [Advanced Men]', 'Nordica', 'Advanced men all-mountain', 'c-1', 'SKI-010', 'ACTIVE', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
  ('PSK011', 'Nordica Santa Ana 88 [Advanced Women]', 'Nordica', 'Advanced women all-mountain', 'c-1', 'SKI-011', 'ACTIVE', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
  ('PSK012', 'Blizzard Brahma 88 [Advanced Men]', 'Blizzard', 'Advanced men all-mountain', 'c-1', 'SKI-012', 'ACTIVE', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
  ('PSK013', 'Blizzard Black Pearl 82 [Intermediate Women]', 'Blizzard', 'Intermediate women all-mountain', 'c-1', 'SKI-013', 'ACTIVE', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
  ('PSK014', 'Volkl Deacon 80 [Intermediate Men]', 'Volkl', 'Intermediate men on-piste', 'c-1', 'SKI-014', 'ACTIVE', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
  ('PSK015', 'Volkl Flair 76 [Beginner Women]', 'Volkl', 'Beginner women on-piste', 'c-1', 'SKI-015', 'ACTIVE', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
  ('PSK016', 'Elan Wingman 82 [Intermediate Men]', 'Elan', 'Intermediate men all-mountain', 'c-1', 'SKI-016', 'ACTIVE', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
  ('PSK017', 'Elan Insomnia 84 [Advanced Women]', 'Elan', 'Advanced women on-piste', 'c-1', 'SKI-017', 'ACTIVE', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
  ('PSK018', 'Dynastar Menace 90 [Beginner Men]', 'Dynastar', 'Beginner men park/all-mountain', 'c-1', 'SKI-018', 'ACTIVE', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
  ('PSK019', 'Atomic Vantage 75 C [Beginner Women]', 'Atomic', 'Beginner women all-mountain', 'c-1', 'SKI-019', 'ACTIVE', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
  ('PSK020', 'Salomon QST Spark Jr [Junior]', 'Salomon', 'Junior twin-tip', 'c-1', 'SKI-020', 'ACTIVE', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),

  -- Boots (c-boots)
  ('PBT001', 'Salomon S/Pro 100 [Advanced Men]', 'Salomon', 'Advanced men all-mountain', 'c-boots', 'BOOT-001', 'ACTIVE', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
  ('PBT002', 'Salomon S/Pro 90 W [Advanced Women]', 'Salomon', 'Advanced women all-mountain', 'c-boots', 'BOOT-002', 'ACTIVE', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
  ('PBT003', 'Atomic Hawx Prime 100 [Intermediate Men]', 'Atomic', 'Intermediate men', 'c-boots', 'BOOT-003', 'ACTIVE', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
  ('PBT004', 'Atomic Hawx Prime 95 W [Intermediate Women]', 'Atomic', 'Intermediate women', 'c-boots', 'BOOT-004', 'ACTIVE', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
  ('PBT005', 'Lange RX 120 [Advanced Men]', 'Lange', 'Advanced men', 'c-boots', 'BOOT-005', 'ACTIVE', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
  ('PBT006', 'Lange RX 90 W [Intermediate Women]', 'Lange', 'Intermediate women', 'c-boots', 'BOOT-006', 'ACTIVE', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
  ('PBT007', 'Tecnica Mach1 120 [Advanced Men]', 'Tecnica', 'Advanced men', 'c-boots', 'BOOT-007', 'ACTIVE', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
  ('PBT008', 'Tecnica Mach1 95 W [Advanced Women]', 'Tecnica', 'Advanced women', 'c-boots', 'BOOT-008', 'ACTIVE', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
  ('PBT009', 'Nordica Speedmachine 110 [Intermediate Men]', 'Nordica', 'Intermediate men', 'c-boots', 'BOOT-009', 'ACTIVE', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
  ('PBT010', 'Nordica Speedmachine 95 W [Intermediate Women]', 'Nordica', 'Intermediate women', 'c-boots', 'BOOT-010', 'ACTIVE', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
  ('PBT011', 'Dalbello Panterra 100 [Intermediate Men]', 'Dalbello', 'Intermediate men', 'c-boots', 'BOOT-011', 'ACTIVE', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
  ('PBT012', 'Dalbello Panterra 95 W [Intermediate Women]', 'Dalbello', 'Intermediate women', 'c-boots', 'BOOT-012', 'ACTIVE', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
  ('PBT013', 'Head Nexo LYT 110 [Advanced Men]', 'Head', 'Advanced men lightweight', 'c-boots', 'BOOT-013', 'ACTIVE', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
  ('PBT014', 'Head Nexo LYT 100 W [Advanced Women]', 'Head', 'Advanced women lightweight', 'c-boots', 'BOOT-014', 'ACTIVE', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
  ('PBT015', 'Fischer Ranger 110 [Intermediate Men]', 'Fischer', 'Intermediate men freeride', 'c-boots', 'BOOT-015', 'ACTIVE', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
  ('PBT016', 'Fischer My Ranger 90 [Intermediate Women]', 'Fischer', 'Intermediate women freeride', 'c-boots', 'BOOT-016', 'ACTIVE', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
  ('PBT017', 'K2 BFC 100 [Beginner Men]', 'K2', 'Beginner men', 'c-boots', 'BOOT-017', 'ACTIVE', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
  ('PBT018', 'K2 BFC W 90 [Beginner Women]', 'K2', 'Beginner women', 'c-boots', 'BOOT-018', 'ACTIVE', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
  ('PBT019', 'Rossignol Alltrack 90 [Beginner Men]', 'Rossignol', 'Beginner men', 'c-boots', 'BOOT-019', 'ACTIVE', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
  ('PBT020', 'Rossignol Alltrack 80 W [Beginner Women]', 'Rossignol', 'Beginner women', 'c-boots', 'BOOT-020', 'ACTIVE', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),

  -- Wear (c-wear)
  ('PWR001', 'Descente Mizusawa Down Storm [Men]', 'Descente', 'Advanced men waterproof down', 'c-wear', 'WEAR-001', 'ACTIVE', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
  ('PWR002', 'Descente Mizusawa Down Anchor [Women]', 'Descente', 'Advanced women waterproof down', 'c-wear', 'WEAR-002', 'ACTIVE', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
  ('PWR003', 'Goldwin Alpine Jacket G1030 [Men]', 'Goldwin', 'Intermediate men jacket', 'c-wear', 'WEAR-003', 'ACTIVE', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
  ('PWR004', 'Goldwin Alpine Jacket G3030 [Women]', 'Goldwin', 'Intermediate women jacket', 'c-wear', 'WEAR-004', 'ACTIVE', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
  ('PWR005', 'Phenix Norway Alpine Team Jacket [Men]', 'Phenix', 'Advanced men team model', 'c-wear', 'WEAR-005', 'ACTIVE', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
  ('PWR006', 'Phenix Demo Team Jacket [Women]', 'Phenix', 'Advanced women demo model', 'c-wear', 'WEAR-006', 'ACTIVE', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
  ('PWR007', 'The North Face Steep Tech Apogee [Men]', 'The North Face', 'Advanced men freeride', 'c-wear', 'WEAR-007', 'ACTIVE', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
  ('PWR008', 'The North Face Garner Triclimate [Women]', 'The North Face', 'Intermediate women 3-in-1', 'c-wear', 'WEAR-008', 'ACTIVE', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
  ('PWR009', 'Patagonia SnowDrifter Jacket [Men]', 'Patagonia', 'Intermediate men backcountry', 'c-wear', 'WEAR-009', 'ACTIVE', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
  ('PWR010', 'Patagonia Snowbelle Jacket [Women]', 'Patagonia', 'Intermediate women all-mountain', 'c-wear', 'WEAR-010', 'ACTIVE', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
  ('PWR011', 'Burton AK Swash Jacket [Men]', 'Burton', 'Advanced men AK series', 'c-wear', 'WEAR-011', 'ACTIVE', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
  ('PWR012', 'Burton AK Embark Jacket [Women]', 'Burton', 'Advanced women AK series', 'c-wear', 'WEAR-012', 'ACTIVE', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
  ('PWR013', 'Descente S.I.O INSULATED PANTS [Men]', 'Descente', 'Men insulated pants', 'c-wear', 'WEAR-013', 'ACTIVE', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
  ('PWR014', 'Descente S.I.O INSULATED PANTS W [Women]', 'Descente', 'Women insulated pants', 'c-wear', 'WEAR-014', 'ACTIVE', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
  ('PWR015', 'Goldwin Cordura Pants [Men]', 'Goldwin', 'Men insulated pants', 'c-wear', 'WEAR-015', 'ACTIVE', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
  ('PWR016', 'Goldwin Slim Pants [Women]', 'Goldwin', 'Women insulated pants', 'c-wear', 'WEAR-016', 'ACTIVE', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
  ('PWR017', 'Phenix Demo Team Pants [Men]', 'Phenix', 'Men insulated pants', 'c-wear', 'WEAR-017', 'ACTIVE', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
  ('PWR018', 'Phenix Aurora Pants [Women]', 'Phenix', 'Women insulated pants', 'c-wear', 'WEAR-018', 'ACTIVE', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
  ('PWR019', 'Burton Exile Cargo Pants [Junior]', 'Burton', 'Junior', 'c-wear', 'WEAR-019', 'ACTIVE', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
  ('PWR020', 'The North Face Freedom Triclimate [Junior]', 'The North Face', 'Junior', 'c-wear', 'WEAR-020', 'ACTIVE', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),

  -- Helmet (c-helmet)
  ('PHL001', 'Giro Range MIPS [Men]', 'Giro', 'Advanced men', 'c-helmet', 'HELM-001', 'ACTIVE', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
  ('PHL002', 'Giro Stellar MIPS [Women]', 'Giro', 'Advanced women', 'c-helmet', 'HELM-002', 'ACTIVE', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
  ('PHL003', 'Smith Vantage MIPS [Men]', 'Smith', 'Advanced men', 'c-helmet', 'HELM-003', 'ACTIVE', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
  ('PHL004', 'Smith Liberty MIPS [Women]', 'Smith', 'Advanced women', 'c-helmet', 'HELM-004', 'ACTIVE', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
  ('PHL005', 'POC Obex SPIN [Men]', 'POC', 'Intermediate men', 'c-helmet', 'HELM-005', 'ACTIVE', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
  ('PHL006', 'POC Obex Pure [Women]', 'POC', 'Intermediate women', 'c-helmet', 'HELM-006', 'ACTIVE', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
  ('PHL007', 'Atomic Revent+ AMID [Men]', 'Atomic', 'Advanced men', 'c-helmet', 'HELM-007', 'ACTIVE', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
  ('PHL008', 'Atomic Revent Q AMID [Women]', 'Atomic', 'Advanced women', 'c-helmet', 'HELM-008', 'ACTIVE', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
  ('PHL009', 'Salomon Pioneer LT [Men]', 'Salomon', 'Intermediate men', 'c-helmet', 'HELM-009', 'ACTIVE', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
  ('PHL010', 'Salomon Icon LT [Women]', 'Salomon', 'Intermediate women', 'c-helmet', 'HELM-010', 'ACTIVE', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
  ('PHL011', 'Scott Symbol 2 Plus [Men]', 'Scott', 'Advanced men', 'c-helmet', 'HELM-011', 'ACTIVE', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
  ('PHL012', 'Scott Keeper 2 JR [Junior]', 'Scott', 'Junior', 'c-helmet', 'HELM-012', 'ACTIVE', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
  ('PHL013', 'Marker Ampire 2 MIPS [Men]', 'Marker', 'Intermediate men', 'c-helmet', 'HELM-013', 'ACTIVE', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
  ('PHL014', 'Marker Companion W [Women]', 'Marker', 'Intermediate women', 'c-helmet', 'HELM-014', 'ACTIVE', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
  ('PHL015', 'Sweet Protection Switcher [Men]', 'Sweet Protection', 'Advanced men', 'c-helmet', 'HELM-015', 'ACTIVE', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
  ('PHL016', 'Sweet Protection Igniter 2Vi [Men]', 'Sweet Protection', 'Advanced men lightweight', 'c-helmet', 'HELM-016', 'ACTIVE', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
  ('PHL017', 'Giro Crue Youth [Junior]', 'Giro', 'Junior', 'c-helmet', 'HELM-017', 'ACTIVE', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
  ('PHL018', 'Smith Holt Jr [Junior]', 'Smith', 'Junior', 'c-helmet', 'HELM-018', 'ACTIVE', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
  ('PHL019', 'Salomon Grom [Junior]', 'Salomon', 'Junior', 'c-helmet', 'HELM-019', 'ACTIVE', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
  ('PHL020', 'POC Pocito Fornix [Junior]', 'POC', 'Junior', 'c-helmet', 'HELM-020', 'ACTIVE', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),

  -- Gloves (c-glove)
  ('PGL001', 'Hestra Army Leather Heli Ski [Men]', 'Hestra', 'Advanced men', 'c-glove', 'GLOVE-001', 'ACTIVE', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
  ('PGL002', 'Hestra Army Leather Heli Ski W [Women]', 'Hestra', 'Advanced women', 'c-glove', 'GLOVE-002', 'ACTIVE', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
  ('PGL003', 'Hestra Fall Line 5-Finger [Men]', 'Hestra', 'Advanced men', 'c-glove', 'GLOVE-003', 'ACTIVE', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
  ('PGL004', 'Black Diamond Guide [Men]', 'Black Diamond', 'Advanced men', 'c-glove', 'GLOVE-004', 'ACTIVE', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
  ('PGL005', 'Black Diamond Mercury Mitts [Women]', 'Black Diamond', 'Advanced women mittens', 'c-glove', 'GLOVE-005', 'ACTIVE', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
  ('PGL006', 'Burton Gore-Tex Gloves [Men]', 'Burton', 'Intermediate men', 'c-glove', 'GLOVE-006', 'ACTIVE', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
  ('PGL007', 'Burton Gore-Tex Gloves W [Women]', 'Burton', 'Intermediate women', 'c-glove', 'GLOVE-007', 'ACTIVE', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
  ('PGL008', 'Leki Griffin Pro 3D [Men]', 'Leki', 'Advanced men', 'c-glove', 'GLOVE-008', 'ACTIVE', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
  ('PGL009', 'Dakine Titan Gore-Tex [Men]', 'Dakine', 'Intermediate men', 'c-glove', 'GLOVE-009', 'ACTIVE', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
  ('PGL010', 'Dakine Sequoia Gore-Tex [Women]', 'Dakine', 'Intermediate women', 'c-glove', 'GLOVE-010', 'ACTIVE', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
  ('PGL011', 'Reusch Worldcup Warrior [Men]', 'Reusch', 'Advanced men racing gloves', 'c-glove', 'GLOVE-011', 'ACTIVE', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
  ('PGL012', 'Swany Toaster Mitt [Men]', 'Swany', 'Intermediate men mittens', 'c-glove', 'GLOVE-012', 'ACTIVE', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
  ('PGL013', 'Level Fly Snowboard Gloves [Men]', 'Level', 'Intermediate men', 'c-glove', 'GLOVE-013', 'ACTIVE', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
  ('PGL014', 'Level Bliss Coral W [Women]', 'Level', 'Intermediate women', 'c-glove', 'GLOVE-014', 'ACTIVE', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
  ('PGL015', 'Burton Profile Mitt [Junior]', 'Burton', 'Junior', 'c-glove', 'GLOVE-015', 'ACTIVE', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
  ('PGL016', 'Hestra Gauntlet CZone Jr [Junior]', 'Hestra', 'Junior', 'c-glove', 'GLOVE-016', 'ACTIVE', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
  ('PGL017', 'Black Diamond Spark Jr [Junior]', 'Black Diamond', 'Junior', 'c-glove', 'GLOVE-017', 'ACTIVE', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
  ('PGL018', 'POW Index Trigger [Men]', 'POW', 'Intermediate men', 'c-glove', 'GLOVE-018', 'ACTIVE', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
  ('PGL019', 'POW Stealth GTX [Women]', 'POW', 'Intermediate women', 'c-glove', 'GLOVE-019', 'ACTIVE', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
  ('PGL020', 'Hestra Wakayama [Unisex]', 'Hestra', 'Intermediate unisex gloves', 'c-glove', 'GLOVE-020', 'ACTIVE', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),

  -- Poles (c-pole)
  ('PPL001', 'Leki Carbon 14 3D [Men]', 'Leki', 'Advanced men lightweight carbon', 'c-pole', 'POLE-001', 'ACTIVE', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
  ('PPL002', 'Leki Legacy Lite S [Women]', 'Leki', 'Intermediate women', 'c-pole', 'POLE-002', 'ACTIVE', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
  ('PPL003', 'Komperdell Nationalteam Carbon [Men]', 'Komperdell', 'Advanced men racing gloves', 'c-pole', 'POLE-003', 'ACTIVE', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
  ('PPL004', 'Black Diamond Razor Carbon [Men]', 'Black Diamond', 'Advanced men backcountry', 'c-pole', 'POLE-004', 'ACTIVE', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
  ('PPL005', 'Salomon MTN Carbon S3 [Men]', 'Salomon', 'Advanced men backcountry', 'c-pole', 'POLE-005', 'ACTIVE', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
  ('PPL006', 'Scott Team Issue SRS [Men]', 'Scott', 'Advanced men', 'c-pole', 'POLE-006', 'ACTIVE', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
  ('PPL007', 'Atomic AMT SQS W [Women]', 'Atomic', 'Intermediate women', 'c-pole', 'POLE-007', 'ACTIVE', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
  ('PPL008', 'Rossignol Hero GS [Men]', 'Rossignol', 'Advanced men racing gloves', 'c-pole', 'POLE-008', 'ACTIVE', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
  ('PPL009', 'K2 Power Composite [Men]', 'K2', 'Intermediate men', 'c-pole', 'POLE-009', 'ACTIVE', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
  ('PPL010', 'Fischer BCX Variolite [Men]', 'Fischer', 'Intermediate men backcountry', 'c-pole', 'POLE-010', 'ACTIVE', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
  ('PPL011', 'Gabel Carbon Force WI [Men]', 'Gabel', 'Advanced men', 'c-pole', 'POLE-011', 'ACTIVE', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
  ('PPL012', 'Swix Quantum 6 [Men]', 'Swix', 'Intermediate men', 'c-pole', 'POLE-012', 'ACTIVE', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
  ('PPL013', 'Komperdell Fatso Carbon [Men]', 'Komperdell', 'Advanced men', 'c-pole', 'POLE-013', 'ACTIVE', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
  ('PPL014', 'Leki Detect S [Men]', 'Leki', 'Intermediate men', 'c-pole', 'POLE-014', 'ACTIVE', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
  ('PPL015', 'Salomon Arctic Lady [Women]', 'Salomon', 'Intermediate women', 'c-pole', 'POLE-015', 'ACTIVE', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
  ('PPL016', 'Black Diamond Expedition 2 [Unisex]', 'Black Diamond', 'Unisex backcountry', 'c-pole', 'POLE-016', 'ACTIVE', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
  ('PPL017', 'Scott Cascade C [Unisex]', 'Scott', 'Unisex carbon poles', 'c-pole', 'POLE-017', 'ACTIVE', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
  ('PPL018', 'Atomic Cloud W [Women]', 'Atomic', 'Women on-piste', 'c-pole', 'POLE-018', 'ACTIVE', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
  ('PPL019', 'Rossignol Electra [Women]', 'Rossignol', 'Women on-piste', 'c-pole', 'POLE-019', 'ACTIVE', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
  ('PPL020', 'Leki Rider Jr [Junior]', 'Leki', 'Junior', 'c-pole', 'POLE-020', 'ACTIVE', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),

  -- Wax (c-wax)
  ('PWX001', 'Swix HS6 Blue -6/-12℃', 'Swix', 'Advanced racing cold temp', 'c-wax', 'WAX-001', 'ACTIVE', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
  ('PWX002', 'Swix HS7 Violet -2/-8℃', 'Swix', 'Advanced racing cool temp', 'c-wax', 'WAX-002', 'ACTIVE', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
  ('PWX003', 'Swix HS8 Red -4/+4℃', 'Swix', 'Advanced racing mid temp', 'c-wax', 'WAX-003', 'ACTIVE', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
  ('PWX004', 'Swix HS10 Yellow 0/+10℃', 'Swix', 'Advanced racing warm temp', 'c-wax', 'WAX-004', 'ACTIVE', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
  ('PWX005', 'Swix PS6 Blue -6/-12℃', 'Swix', 'Intermediate maintenance cold', 'c-wax', 'WAX-005', 'ACTIVE', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
  ('PWX006', 'Swix PS7 Violet -2/-8℃', 'Swix', 'Intermediate maintenance cool', 'c-wax', 'WAX-006', 'ACTIVE', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
  ('PWX007', 'Swix PS8 Red -4/+4℃', 'Swix', 'Intermediate maintenance mid', 'c-wax', 'WAX-007', 'ACTIVE', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
  ('PWX008', 'Swix PS10 Yellow 0/+10℃', 'Swix', 'Intermediate maintenance warm', 'c-wax', 'WAX-008', 'ACTIVE', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
  ('PWX009', 'Holmenkol Betamix Red -4/-14℃', 'Holmenkol', 'Advanced racing wax', 'c-wax', 'WAX-009', 'ACTIVE', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
  ('PWX010', 'Holmenkol Ultramix Blue -8/-20℃', 'Holmenkol', 'Advanced racing cold temp', 'c-wax', 'WAX-010', 'ACTIVE', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
  ('PWX011', 'TOKO NF Blue -10/-30℃', 'TOKO', 'Intermediate maintenance cold', 'c-wax', 'WAX-011', 'ACTIVE', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
  ('PWX012', 'TOKO NF Red -4/-12℃', 'TOKO', 'Intermediate maintenance mid', 'c-wax', 'WAX-012', 'ACTIVE', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
  ('PWX013', 'Gallium Base Wax Pink -3/+5℃', 'Gallium', 'Beginner maintenance wax', 'c-wax', 'WAX-013', 'ACTIVE', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
  ('PWX014', 'Hertel Hot Sauce All Temp', 'Hertel', 'Beginner all-round', 'c-wax', 'WAX-014', 'ACTIVE', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
  ('PWX015', 'Purl Purple All Temp', 'Purl', 'Beginner all-round', 'c-wax', 'WAX-015', 'ACTIVE', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
  ('PWX016', 'Dominator Zoom Lime 0/+10℃', 'Dominator', 'Advanced warm temp', 'c-wax', 'WAX-016', 'ACTIVE', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
  ('PWX017', 'Briko-Maplus BP1 Med -5/+5℃', 'Briko-Maplus', 'Intermediate all-round', 'c-wax', 'WAX-017', 'ACTIVE', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
  ('PWX018', 'OneBall Jay Fluoro-Free All Temp', 'OneBall', 'Beginner all-round', 'c-wax', 'WAX-018', 'ACTIVE', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
  ('PWX019', 'Swix F4 Universal Glidewax', 'Swix', 'Beginner liquid wax', 'c-wax', 'WAX-019', 'ACTIVE', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
  ('PWX020', 'TOKO Express Pocket Warm', 'TOKO', 'Beginner liquid warm temp', 'c-wax', 'WAX-020', 'ACTIVE', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);

INSERT INTO prices(id, product_id, regular_price, sale_price, currency_code, sale_start_date, sale_end_date) VALUES
  ('price-1', 'P001', 333, NULL, 'USD', NULL, NULL);

INSERT INTO prices(id, product_id, regular_price, sale_price, currency_code, sale_start_date, sale_end_date) VALUES
  -- Skis
  ('price-PSK001', 'PSK001', 853, NULL, 'USD', NULL, NULL),
  ('price-PSK002', 'PSK002', 833, NULL, 'USD', NULL, NULL),
  ('price-PSK003', 'PSK003', 800, NULL, 'USD', NULL, NULL),
  ('price-PSK004', 'PSK004', 653, NULL, 'USD', NULL, NULL),
  ('price-PSK005', 'PSK005', 613, NULL, 'USD', NULL, NULL),
  ('price-PSK006', 'PSK006', 900, NULL, 'USD', NULL, NULL),
  ('price-PSK007', 'PSK007', 787, NULL, 'USD', NULL, NULL),
  ('price-PSK008', 'PSK008', 640, NULL, 'USD', NULL, NULL),
  ('price-PSK009', 'PSK009', 453, NULL, 'USD', NULL, NULL),
  ('price-PSK010', 'PSK010', 767, NULL, 'USD', NULL, NULL),
  ('price-PSK011', 'PSK011', 747, NULL, 'USD', NULL, NULL),
  ('price-PSK012', 'PSK012', 787, NULL, 'USD', NULL, NULL),
  ('price-PSK013', 'PSK013', 653, NULL, 'USD', NULL, NULL),
  ('price-PSK014', 'PSK014', 613, NULL, 'USD', NULL, NULL),
  ('price-PSK015', 'PSK015', 520, NULL, 'USD', NULL, NULL),
  ('price-PSK016', 'PSK016', 633, NULL, 'USD', NULL, NULL),
  ('price-PSK017', 'PSK017', 660, NULL, 'USD', NULL, NULL),
  ('price-PSK018', 'PSK018', 480, NULL, 'USD', NULL, NULL),
  ('price-PSK019', 'PSK019', 467, NULL, 'USD', NULL, NULL),
  ('price-PSK020', 'PSK020', 300, NULL, 'USD', NULL, NULL),
  -- Boots
  ('price-PBT001', 'PBT001', 453, NULL, 'USD', NULL, NULL),
  ('price-PBT002', 'PBT002', 433, NULL, 'USD', NULL, NULL),
  ('price-PBT003', 'PBT003', 413, NULL, 'USD', NULL, NULL),
  ('price-PBT004', 'PBT004', 400, NULL, 'USD', NULL, NULL),
  ('price-PBT005', 'PBT005', 480, NULL, 'USD', NULL, NULL),
  ('price-PBT006', 'PBT006', 453, NULL, 'USD', NULL, NULL),
  ('price-PBT007', 'PBT007', 493, NULL, 'USD', NULL, NULL),
  ('price-PBT008', 'PBT008', 467, NULL, 'USD', NULL, NULL),
  ('price-PBT009', 'PBT009', 433, NULL, 'USD', NULL, NULL),
  ('price-PBT010', 'PBT010', 420, NULL, 'USD', NULL, NULL),
  ('price-PBT011', 'PBT011', 427, NULL, 'USD', NULL, NULL),
  ('price-PBT012', 'PBT012', 413, NULL, 'USD', NULL, NULL),
  ('price-PBT013', 'PBT013', 480, NULL, 'USD', NULL, NULL),
  ('price-PBT014', 'PBT014', 467, NULL, 'USD', NULL, NULL),
  ('price-PBT015', 'PBT015', 440, NULL, 'USD', NULL, NULL),
  ('price-PBT016', 'PBT016', 427, NULL, 'USD', NULL, NULL),
  ('price-PBT017', 'PBT017', 347, NULL, 'USD', NULL, NULL),
  ('price-PBT018', 'PBT018', 333, NULL, 'USD', NULL, NULL),
  ('price-PBT019', 'PBT019', 320, NULL, 'USD', NULL, NULL),
  ('price-PBT020', 'PBT020', 307, NULL, 'USD', NULL, NULL),
  -- Wear
  ('price-PWR001', 'PWR001', 653, NULL, 'USD', NULL, NULL),
  ('price-PWR002', 'PWR002', 633, NULL, 'USD', NULL, NULL),
  ('price-PWR003', 'PWR003', 453, NULL, 'USD', NULL, NULL),
  ('price-PWR004', 'PWR004', 433, NULL, 'USD', NULL, NULL),
  ('price-PWR005', 'PWR005', 600, NULL, 'USD', NULL, NULL),
  ('price-PWR006', 'PWR006', 587, NULL, 'USD', NULL, NULL),
  ('price-PWR007', 'PWR007', 553, NULL, 'USD', NULL, NULL),
  ('price-PWR008', 'PWR008', 480, NULL, 'USD', NULL, NULL),
  ('price-PWR009', 'PWR009', 520, NULL, 'USD', NULL, NULL),
  ('price-PWR010', 'PWR010', 480, NULL, 'USD', NULL, NULL),
  ('price-PWR011', 'PWR011', 567, NULL, 'USD', NULL, NULL),
  ('price-PWR012', 'PWR012', 553, NULL, 'USD', NULL, NULL),
  ('price-PWR013', 'PWR013', 347, NULL, 'USD', NULL, NULL),
  ('price-PWR014', 'PWR014', 333, NULL, 'USD', NULL, NULL),
  ('price-PWR015', 'PWR015', 333, NULL, 'USD', NULL, NULL),
  ('price-PWR016', 'PWR016', 320, NULL, 'USD', NULL, NULL),
  ('price-PWR017', 'PWR017', 347, NULL, 'USD', NULL, NULL),
  ('price-PWR018', 'PWR018', 333, NULL, 'USD', NULL, NULL),
  ('price-PWR019', 'PWR019', 253, NULL, 'USD', NULL, NULL),
  ('price-PWR020', 'PWR020', 240, NULL, 'USD', NULL, NULL),
  -- Helmet
  ('price-PHL001', 'PHL001', 213, NULL, 'USD', NULL, NULL),
  ('price-PHL002', 'PHL002', 207, NULL, 'USD', NULL, NULL),
  ('price-PHL003', 'PHL003', 200, NULL, 'USD', NULL, NULL),
  ('price-PHL004', 'PHL004', 193, NULL, 'USD', NULL, NULL),
  ('price-PHL005', 'PHL005', 187, NULL, 'USD', NULL, NULL),
  ('price-PHL006', 'PHL006', 180, NULL, 'USD', NULL, NULL),
  ('price-PHL007', 'PHL007', 200, NULL, 'USD', NULL, NULL),
  ('price-PHL008', 'PHL008', 197, NULL, 'USD', NULL, NULL),
  ('price-PHL009', 'PHL009', 173, NULL, 'USD', NULL, NULL),
  ('price-PHL010', 'PHL010', 167, NULL, 'USD', NULL, NULL),
  ('price-PHL011', 'PHL011', 187, NULL, 'USD', NULL, NULL),
  ('price-PHL012', 'PHL012', 120, NULL, 'USD', NULL, NULL),
  ('price-PHL013', 'PHL013', 167, NULL, 'USD', NULL, NULL),
  ('price-PHL014', 'PHL014', 160, NULL, 'USD', NULL, NULL),
  ('price-PHL015', 'PHL015', 220, NULL, 'USD', NULL, NULL),
  ('price-PHL016', 'PHL016', 213, NULL, 'USD', NULL, NULL),
  ('price-PHL017', 'PHL017', 107, NULL, 'USD', NULL, NULL),
  ('price-PHL018', 'PHL018', 100, NULL, 'USD', NULL, NULL),
  ('price-PHL019', 'PHL019', 93, NULL, 'USD', NULL, NULL),
  ('price-PHL020', 'PHL020', 133, NULL, 'USD', NULL, NULL),
  -- Gloves
  ('price-PGL001', 'PGL001', 147, NULL, 'USD', NULL, NULL),
  ('price-PGL002', 'PGL002', 140, NULL, 'USD', NULL, NULL),
  ('price-PGL003', 'PGL003', 133, NULL, 'USD', NULL, NULL),
  ('price-PGL004', 'PGL004', 133, NULL, 'USD', NULL, NULL),
  ('price-PGL005', 'PGL005', 127, NULL, 'USD', NULL, NULL),
  ('price-PGL006', 'PGL006', 100, NULL, 'USD', NULL, NULL),
  ('price-PGL007', 'PGL007', 100, NULL, 'USD', NULL, NULL),
  ('price-PGL008', 'PGL008', 120, NULL, 'USD', NULL, NULL),
  ('price-PGL009', 'PGL009', 93, NULL, 'USD', NULL, NULL),
  ('price-PGL010', 'PGL010', 93, NULL, 'USD', NULL, NULL),
  ('price-PGL011', 'PGL011', 133, NULL, 'USD', NULL, NULL),
  ('price-PGL012', 'PGL012', 107, NULL, 'USD', NULL, NULL),
  ('price-PGL013', 'PGL013', 93, NULL, 'USD', NULL, NULL),
  ('price-PGL014', 'PGL014', 87, NULL, 'USD', NULL, NULL),
  ('price-PGL015', 'PGL015', 60, NULL, 'USD', NULL, NULL),
  ('price-PGL016', 'PGL016', 73, NULL, 'USD', NULL, NULL),
  ('price-PGL017', 'PGL017', 60, NULL, 'USD', NULL, NULL),
  ('price-PGL018', 'PGL018', 87, NULL, 'USD', NULL, NULL),
  ('price-PGL019', 'PGL019', 87, NULL, 'USD', NULL, NULL),
  ('price-PGL020', 'PGL020', 113, NULL, 'USD', NULL, NULL),
  -- Poles
  ('price-PPL001', 'PPL001', 147, NULL, 'USD', NULL, NULL),
  ('price-PPL002', 'PPL002', 107, NULL, 'USD', NULL, NULL),
  ('price-PPL003', 'PPL003', 160, NULL, 'USD', NULL, NULL),
  ('price-PPL004', 'PPL004', 167, NULL, 'USD', NULL, NULL),
  ('price-PPL005', 'PPL005', 167, NULL, 'USD', NULL, NULL),
  ('price-PPL006', 'PPL006', 133, NULL, 'USD', NULL, NULL),
  ('price-PPL007', 'PPL007', 100, NULL, 'USD', NULL, NULL),
  ('price-PPL008', 'PPL008', 120, NULL, 'USD', NULL, NULL),
  ('price-PPL009', 'PPL009', 93, NULL, 'USD', NULL, NULL),
  ('price-PPL010', 'PPL010', 107, NULL, 'USD', NULL, NULL),
  ('price-PPL011', 'PPL011', 120, NULL, 'USD', NULL, NULL),
  ('price-PPL012', 'PPL012', 100, NULL, 'USD', NULL, NULL),
  ('price-PPL013', 'PPL013', 133, NULL, 'USD', NULL, NULL),
  ('price-PPL014', 'PPL014', 113, NULL, 'USD', NULL, NULL),
  ('price-PPL015', 'PPL015', 100, NULL, 'USD', NULL, NULL),
  ('price-PPL016', 'PPL016', 120, NULL, 'USD', NULL, NULL),
  ('price-PPL017', 'PPL017', 117, NULL, 'USD', NULL, NULL),
  ('price-PPL018', 'PPL018', 100, NULL, 'USD', NULL, NULL),
  ('price-PPL019', 'PPL019', 100, NULL, 'USD', NULL, NULL),
  ('price-PPL020', 'PPL020', 53, NULL, 'USD', NULL, NULL),
  -- Wax
  ('price-PWX001', 'PWX001', 20, NULL, 'USD', NULL, NULL),
  ('price-PWX002', 'PWX002', 20, NULL, 'USD', NULL, NULL),
  ('price-PWX003', 'PWX003', 20, NULL, 'USD', NULL, NULL),
  ('price-PWX004', 'PWX004', 20, NULL, 'USD', NULL, NULL),
  ('price-PWX005', 'PWX005', 13, NULL, 'USD', NULL, NULL),
  ('price-PWX006', 'PWX006', 13, NULL, 'USD', NULL, NULL),
  ('price-PWX007', 'PWX007', 13, NULL, 'USD', NULL, NULL),
  ('price-PWX008', 'PWX008', 13, NULL, 'USD', NULL, NULL),
  ('price-PWX009', 'PWX009', 17, NULL, 'USD', NULL, NULL),
  ('price-PWX010', 'PWX010', 17, NULL, 'USD', NULL, NULL),
  ('price-PWX011', 'PWX011', 12, NULL, 'USD', NULL, NULL),
  ('price-PWX012', 'PWX012', 12, NULL, 'USD', NULL, NULL),
  ('price-PWX013', 'PWX013', 10, NULL, 'USD', NULL, NULL),
  ('price-PWX014', 'PWX014', 10, NULL, 'USD', NULL, NULL),
  ('price-PWX015', 'PWX015', 10, NULL, 'USD', NULL, NULL),
  ('price-PWX016', 'PWX016', 15, NULL, 'USD', NULL, NULL),
  ('price-PWX017', 'PWX017', 13, NULL, 'USD', NULL, NULL),
  ('price-PWX018', 'PWX018', 11, NULL, 'USD', NULL, NULL),
  ('price-PWX019', 'PWX019', 11, NULL, 'USD', NULL, NULL),
  ('price-PWX020', 'PWX020', 11, NULL, 'USD', NULL, NULL);

INSERT INTO inventory(id, product_id, quantity, reserved_quantity, status) VALUES
  ('inv-1', 'P001', 10, 0, 'AVAILABLE');

INSERT INTO inventory(id, product_id, quantity, reserved_quantity, status) VALUES
  -- Skis
  ('inv-PSK001', 'PSK001', 20, 0, 'AVAILABLE'),
  ('inv-PSK002', 'PSK002', 20, 0, 'AVAILABLE'),
  ('inv-PSK003', 'PSK003', 20, 0, 'AVAILABLE'),
  ('inv-PSK004', 'PSK004', 20, 0, 'AVAILABLE'),
  ('inv-PSK005', 'PSK005', 20, 0, 'AVAILABLE'),
  ('inv-PSK006', 'PSK006', 20, 0, 'AVAILABLE'),
  ('inv-PSK007', 'PSK007', 20, 0, 'AVAILABLE'),
  ('inv-PSK008', 'PSK008', 20, 0, 'AVAILABLE'),
  ('inv-PSK009', 'PSK009', 20, 0, 'AVAILABLE'),
  ('inv-PSK010', 'PSK010', 20, 0, 'AVAILABLE'),
  ('inv-PSK011', 'PSK011', 20, 0, 'AVAILABLE'),
  ('inv-PSK012', 'PSK012', 20, 0, 'AVAILABLE'),
  ('inv-PSK013', 'PSK013', 20, 0, 'AVAILABLE'),
  ('inv-PSK014', 'PSK014', 20, 0, 'AVAILABLE'),
  ('inv-PSK015', 'PSK015', 20, 0, 'AVAILABLE'),
  ('inv-PSK016', 'PSK016', 20, 0, 'AVAILABLE'),
  ('inv-PSK017', 'PSK017', 20, 0, 'AVAILABLE'),
  ('inv-PSK018', 'PSK018', 20, 0, 'AVAILABLE'),
  ('inv-PSK019', 'PSK019', 20, 0, 'AVAILABLE'),
  ('inv-PSK020', 'PSK020', 20, 0, 'AVAILABLE'),
  -- Boots
  ('inv-PBT001', 'PBT001', 20, 0, 'AVAILABLE'),
  ('inv-PBT002', 'PBT002', 20, 0, 'AVAILABLE'),
  ('inv-PBT003', 'PBT003', 20, 0, 'AVAILABLE'),
  ('inv-PBT004', 'PBT004', 20, 0, 'AVAILABLE'),
  ('inv-PBT005', 'PBT005', 20, 0, 'AVAILABLE'),
  ('inv-PBT006', 'PBT006', 20, 0, 'AVAILABLE'),
  ('inv-PBT007', 'PBT007', 20, 0, 'AVAILABLE'),
  ('inv-PBT008', 'PBT008', 20, 0, 'AVAILABLE'),
  ('inv-PBT009', 'PBT009', 20, 0, 'AVAILABLE'),
  ('inv-PBT010', 'PBT010', 20, 0, 'AVAILABLE'),
  ('inv-PBT011', 'PBT011', 20, 0, 'AVAILABLE'),
  ('inv-PBT012', 'PBT012', 20, 0, 'AVAILABLE'),
  ('inv-PBT013', 'PBT013', 20, 0, 'AVAILABLE'),
  ('inv-PBT014', 'PBT014', 20, 0, 'AVAILABLE'),
  ('inv-PBT015', 'PBT015', 20, 0, 'AVAILABLE'),
  ('inv-PBT016', 'PBT016', 20, 0, 'AVAILABLE'),
  ('inv-PBT017', 'PBT017', 20, 0, 'AVAILABLE'),
  ('inv-PBT018', 'PBT018', 20, 0, 'AVAILABLE'),
  ('inv-PBT019', 'PBT019', 20, 0, 'AVAILABLE'),
  ('inv-PBT020', 'PBT020', 20, 0, 'AVAILABLE'),
  -- Wear
  ('inv-PWR001', 'PWR001', 20, 0, 'AVAILABLE'),
  ('inv-PWR002', 'PWR002', 20, 0, 'AVAILABLE'),
  ('inv-PWR003', 'PWR003', 20, 0, 'AVAILABLE'),
  ('inv-PWR004', 'PWR004', 20, 0, 'AVAILABLE'),
  ('inv-PWR005', 'PWR005', 20, 0, 'AVAILABLE'),
  ('inv-PWR006', 'PWR006', 20, 0, 'AVAILABLE'),
  ('inv-PWR007', 'PWR007', 20, 0, 'AVAILABLE'),
  ('inv-PWR008', 'PWR008', 20, 0, 'AVAILABLE'),
  ('inv-PWR009', 'PWR009', 20, 0, 'AVAILABLE'),
  ('inv-PWR010', 'PWR010', 20, 0, 'AVAILABLE'),
  ('inv-PWR011', 'PWR011', 20, 0, 'AVAILABLE'),
  ('inv-PWR012', 'PWR012', 20, 0, 'AVAILABLE'),
  ('inv-PWR013', 'PWR013', 20, 0, 'AVAILABLE'),
  ('inv-PWR014', 'PWR014', 20, 0, 'AVAILABLE'),
  ('inv-PWR015', 'PWR015', 20, 0, 'AVAILABLE'),
  ('inv-PWR016', 'PWR016', 20, 0, 'AVAILABLE'),
  ('inv-PWR017', 'PWR017', 20, 0, 'AVAILABLE'),
  ('inv-PWR018', 'PWR018', 20, 0, 'AVAILABLE'),
  ('inv-PWR019', 'PWR019', 20, 0, 'AVAILABLE'),
  ('inv-PWR020', 'PWR020', 20, 0, 'AVAILABLE'),
  -- Helmet
  ('inv-PHL001', 'PHL001', 20, 0, 'AVAILABLE'),
  ('inv-PHL002', 'PHL002', 20, 0, 'AVAILABLE'),
  ('inv-PHL003', 'PHL003', 20, 0, 'AVAILABLE'),
  ('inv-PHL004', 'PHL004', 20, 0, 'AVAILABLE'),
  ('inv-PHL005', 'PHL005', 20, 0, 'AVAILABLE'),
  ('inv-PHL006', 'PHL006', 20, 0, 'AVAILABLE'),
  ('inv-PHL007', 'PHL007', 20, 0, 'AVAILABLE'),
  ('inv-PHL008', 'PHL008', 20, 0, 'AVAILABLE'),
  ('inv-PHL009', 'PHL009', 20, 0, 'AVAILABLE'),
  ('inv-PHL010', 'PHL010', 20, 0, 'AVAILABLE'),
  ('inv-PHL011', 'PHL011', 20, 0, 'AVAILABLE'),
  ('inv-PHL012', 'PHL012', 20, 0, 'AVAILABLE'),
  ('inv-PHL013', 'PHL013', 20, 0, 'AVAILABLE'),
  ('inv-PHL014', 'PHL014', 20, 0, 'AVAILABLE'),
  ('inv-PHL015', 'PHL015', 20, 0, 'AVAILABLE'),
  ('inv-PHL016', 'PHL016', 20, 0, 'AVAILABLE'),
  ('inv-PHL017', 'PHL017', 20, 0, 'AVAILABLE'),
  ('inv-PHL018', 'PHL018', 20, 0, 'AVAILABLE'),
  ('inv-PHL019', 'PHL019', 20, 0, 'AVAILABLE'),
  ('inv-PHL020', 'PHL020', 20, 0, 'AVAILABLE'),
  -- Gloves
  ('inv-PGL001', 'PGL001', 20, 0, 'AVAILABLE'),
  ('inv-PGL002', 'PGL002', 20, 0, 'AVAILABLE'),
  ('inv-PGL003', 'PGL003', 20, 0, 'AVAILABLE'),
  ('inv-PGL004', 'PGL004', 20, 0, 'AVAILABLE'),
  ('inv-PGL005', 'PGL005', 20, 0, 'AVAILABLE'),
  ('inv-PGL006', 'PGL006', 20, 0, 'AVAILABLE'),
  ('inv-PGL007', 'PGL007', 20, 0, 'AVAILABLE'),
  ('inv-PGL008', 'PGL008', 20, 0, 'AVAILABLE'),
  ('inv-PGL009', 'PGL009', 20, 0, 'AVAILABLE'),
  ('inv-PGL010', 'PGL010', 20, 0, 'AVAILABLE'),
  ('inv-PGL011', 'PGL011', 20, 0, 'AVAILABLE'),
  ('inv-PGL012', 'PGL012', 20, 0, 'AVAILABLE'),
  ('inv-PGL013', 'PGL013', 20, 0, 'AVAILABLE'),
  ('inv-PGL014', 'PGL014', 20, 0, 'AVAILABLE'),
  ('inv-PGL015', 'PGL015', 20, 0, 'AVAILABLE'),
  ('inv-PGL016', 'PGL016', 20, 0, 'AVAILABLE'),
  ('inv-PGL017', 'PGL017', 20, 0, 'AVAILABLE'),
  ('inv-PGL018', 'PGL018', 20, 0, 'AVAILABLE'),
  ('inv-PGL019', 'PGL019', 20, 0, 'AVAILABLE'),
  ('inv-PGL020', 'PGL020', 20, 0, 'AVAILABLE'),
  -- Poles
  ('inv-PPL001', 'PPL001', 20, 0, 'AVAILABLE'),
  ('inv-PPL002', 'PPL002', 20, 0, 'AVAILABLE'),
  ('inv-PPL003', 'PPL003', 20, 0, 'AVAILABLE'),
  ('inv-PPL004', 'PPL004', 20, 0, 'AVAILABLE'),
  ('inv-PPL005', 'PPL005', 20, 0, 'AVAILABLE'),
  ('inv-PPL006', 'PPL006', 20, 0, 'AVAILABLE'),
  ('inv-PPL007', 'PPL007', 20, 0, 'AVAILABLE'),
  ('inv-PPL008', 'PPL008', 20, 0, 'AVAILABLE'),
  ('inv-PPL009', 'PPL009', 20, 0, 'AVAILABLE'),
  ('inv-PPL010', 'PPL010', 20, 0, 'AVAILABLE'),
  ('inv-PPL011', 'PPL011', 20, 0, 'AVAILABLE'),
  ('inv-PPL012', 'PPL012', 20, 0, 'AVAILABLE'),
  ('inv-PPL013', 'PPL013', 20, 0, 'AVAILABLE'),
  ('inv-PPL014', 'PPL014', 20, 0, 'AVAILABLE'),
  ('inv-PPL015', 'PPL015', 20, 0, 'AVAILABLE'),
  ('inv-PPL016', 'PPL016', 20, 0, 'AVAILABLE'),
  ('inv-PPL017', 'PPL017', 20, 0, 'AVAILABLE'),
  ('inv-PPL018', 'PPL018', 20, 0, 'AVAILABLE'),
  ('inv-PPL019', 'PPL019', 20, 0, 'AVAILABLE'),
  ('inv-PPL020', 'PPL020', 20, 0, 'AVAILABLE'),
  -- Wax
  ('inv-PWX001', 'PWX001', 50, 0, 'AVAILABLE'),
  ('inv-PWX002', 'PWX002', 50, 0, 'AVAILABLE'),
  ('inv-PWX003', 'PWX003', 50, 0, 'AVAILABLE'),
  ('inv-PWX004', 'PWX004', 50, 0, 'AVAILABLE'),
  ('inv-PWX005', 'PWX005', 50, 0, 'AVAILABLE'),
  ('inv-PWX006', 'PWX006', 50, 0, 'AVAILABLE'),
  ('inv-PWX007', 'PWX007', 50, 0, 'AVAILABLE'),
  ('inv-PWX008', 'PWX008', 50, 0, 'AVAILABLE'),
  ('inv-PWX009', 'PWX009', 50, 0, 'AVAILABLE'),
  ('inv-PWX010', 'PWX010', 50, 0, 'AVAILABLE'),
  ('inv-PWX011', 'PWX011', 50, 0, 'AVAILABLE'),
  ('inv-PWX012', 'PWX012', 50, 0, 'AVAILABLE'),
  ('inv-PWX013', 'PWX013', 50, 0, 'AVAILABLE'),
  ('inv-PWX014', 'PWX014', 50, 0, 'AVAILABLE'),
  ('inv-PWX015', 'PWX015', 50, 0, 'AVAILABLE'),
  ('inv-PWX016', 'PWX016', 50, 0, 'AVAILABLE'),
  ('inv-PWX017', 'PWX017', 50, 0, 'AVAILABLE'),
  ('inv-PWX018', 'PWX018', 50, 0, 'AVAILABLE'),
  ('inv-PWX019', 'PWX019', 50, 0, 'AVAILABLE'),
  ('inv-PWX020', 'PWX020', 50, 0, 'AVAILABLE');

INSERT INTO carts(id, user_id, session_id, status, expires_at) VALUES
  ('cart-1', 'u-1', 'session-1', 'ACTIVE', CURRENT_TIMESTAMP);

INSERT INTO cart_items(id, cart_id, product_id, quantity, unit_price) VALUES
  ('cart-item-1', 'cart-1', 'P001', 1, 50000);

INSERT INTO payments(id, order_id, cart_id, amount, currency, status, payment_intent_id, created_at) VALUES
  ('pay-1', 'order-1', 'cart-1', 372, 'USD', 'AUTHORIZED', 'PAY-0001', CURRENT_TIMESTAMP);

INSERT INTO orders(id, order_number, user_id, status, payment_status, subtotal, tax, shipping_fee, discount_amount, total_amount, coupon_code, used_points, created_at, updated_at) VALUES
  ('order-1', 'ORD-0001', 'u-1', 'CREATED', 'AUTHORIZED', 50000, 5000, 800, 0, 55800, NULL, 0, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);

INSERT INTO order_items(id, order_id, product_id, product_name, sku, unit_price, quantity, subtotal) VALUES
  ('order-item-1', 'order-1', 'P001', 'Ski A', 'SKU-001', 50000, 1, 50000);

INSERT INTO shipments(id, order_id, carrier, tracking_number, status, shipped_at, delivered_at) VALUES
  ('ship-1', 'order-1', 'Yamato', 'TRK-001', 'PENDING', NULL, NULL);

INSERT INTO returns(id, order_id, order_item_id, reason, quantity, refund_amount, status) VALUES
  ('return-1', 'order-1', 'order-item-1', 'size', 1, 50000, 'REQUESTED');

INSERT INTO order_shipping(id, order_id, recipient_name, postal_code, prefecture, address1, address2, phone, shipping_method_code, shipping_fee, requested_delivery_date) VALUES
  ('os-1', 'order-1', 'John Smith', '160-0022', 'New York', '123 Main Street', 'Apt 101', '0312345678', 'STANDARD', 800, NULL);

INSERT INTO point_accounts(id, user_id, balance, lifetime_earned, lifetime_redeemed) VALUES
  ('pa-1', 'u-1', 100, 100, 0);

INSERT INTO point_transactions(id, user_id, type, amount, reference_id, description, expires_at, is_expired, created_at) VALUES
  ('pt-1', 'u-1', 'EARN', 100, 'order-1', 'Initial points', CURRENT_TIMESTAMP, FALSE, CURRENT_TIMESTAMP);

INSERT INTO campaigns(id, name, description, type, start_date, end_date, is_active, rules_json) VALUES
  ('camp-1', 'Winter', 'Winter campaign', 'SEASONAL', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, TRUE, '{}');

INSERT INTO coupons(id, campaign_id, code, coupon_type, discount_value, discount_type, minimum_amount, maximum_discount, usage_limit, used_count, is_active, expires_at) VALUES
  ('coupon-1', 'camp-1', 'SAVE10', 'PERCENT', 10, 'ORDER', 1000, 5000, 100, 0, TRUE, CURRENT_TIMESTAMP);

INSERT INTO user_addresses(id, user_id, label, recipient_name, postal_code, prefecture, address1, address2, phone, is_default, created_at, updated_at) VALUES
  ('addr-1', 'u-1', 'Home', 'John Smith', '160-0022', 'New York', '123 Main Street', 'Apt 101', '0312345678', TRUE, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);

INSERT INTO password_reset_tokens(id, user_id, token, expires_at, used_at) VALUES
  ('prt-1', 'u-1', 'token-1', CURRENT_TIMESTAMP, NULL);

INSERT INTO shipping_methods(id, code, name, fee, is_active, sort_order) VALUES
  ('ship-std', 'STANDARD', 'Standard', 800, TRUE, 1);

INSERT INTO email_queue(id, to_addr, subject, body, status, retry_count, last_error, scheduled_at, sent_at) VALUES
  ('mail-1', 'user@example.com', 'Welcome', 'Body', 'PENDING', 0, NULL, CURRENT_TIMESTAMP, NULL);
