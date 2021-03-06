require './methods'

imps = parse_imps
log "[NPCI] Got #{imps.keys.size} entries"

rtgs = parse_rtgs
log "[RTGS] Got #{rtgs.keys.size} entries"

neft = parse_neft
log "[NEFT] Got #{neft.keys.size} entries"

log 'Combining the above 3 lists'
dataset = merge_dataset(neft, rtgs, imps)

log "Got total #{dataset.keys.size} entries", :info

dataset = apply_patches(dataset)

log 'Applied patches', :info

# We do this once, to:
# 1. Ensure the same ordering in most datasets (consistency)
# 2. Remove any future .keys calls (speed)
ifsc_codes_list = dataset.keys.sort

log 'Exporting CSV'
export_csv(dataset)

log 'Exporting JSON by Banks'
export_json_by_banks(ifsc_codes_list, dataset)

log 'Exporting JSON List'
export_json_list(ifsc_codes_list)

log 'Exporting to validation JSON'
export_to_code_json(ifsc_codes_list)

log 'Export done'
