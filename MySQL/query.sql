SELECT 
    vm.type AS mapping_type,

    v.id AS vendor_id,
    v.name AS vendor_name,
    v.registered_id AS vendor_registered_id,
    v.email AS vendor_email,

    e.id AS entity_id,
    e.name AS entity_name,
    e.code AS entity_code,
    e.registered_name AS entity_registered_name,

    o.id AS office_id,
    o.name AS office_name,
    o.registered_name AS office_registered_name,
    o.registered_address AS office_registered_address,

    oe.id AS office_entity_id,
    oe.name AS office_entity_name,
    oe.code AS office_entity_code,
    oe.registered_name AS office_entity_registered_name

FROM fintrip.vc_vendor_mapping vm

JOIN fintrip.vc_contacts v 
    ON vm.vendor_id = v.id

LEFT JOIN fintrip.fintrip_entities e 
    ON vm.reference_id = e.id AND vm.type = 'ENTITY'

LEFT JOIN fintrip.fintrip_offices o 
    ON vm.reference_id = o.id AND vm.type = 'OFFICE'

-- Entity linked to office
LEFT JOIN fintrip.fintrip_entities oe 
    ON o.entity_id = oe.id

WHERE vm.company_id = 3254;



SELECT 
    v.id AS vendor_id,
    v.name AS vendor_name,
    v.registered_id AS vendor_registered_id,
    v.email AS vendor_email,

    -- Grouped entity details
    GROUP_CONCAT(DISTINCT e.id) AS entity_ids,
    GROUP_CONCAT(DISTINCT e.name) AS entity_names,
    GROUP_CONCAT(DISTINCT e.code) AS entity_codes,
    GROUP_CONCAT(DISTINCT e.registered_name) AS entity_registered_names

FROM fintrip.vc_vendor_org_mapping vm

JOIN fintrip.vc_contacts v 
    ON vm.vendor_id = v.id

LEFT JOIN fintrip.fintrip_entities e 
    ON vm.reference_id = e.id AND vm.type = 'ENTITY'

WHERE vm.company_id = 3254
  AND vm.type = 'ENTITY'

GROUP BY 
    v.id, v.name, v.registered_id, v.email;
