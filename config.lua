-----------------
---  Options  ---
-----------------

options.timeout = 120
options.subscribe = true


-------------------
---  Libraries  ---
-------------------

require "libs/extra_functions"


-----------------
---  Sorting  ---
-----------------

function sorting(account, config)
    archive = config['archive_dir']
    if type(archive) ~= "string" then
	archive = ""
    elseif string.len(archive) > 0 then
	archive = string.format("%s/", archive)
    end

    BEST_DIR = string.format("%sBEST", archive)

    --- List of needed folders
    NEEDED_FOLDERS = {
        "%s",
        "%s/Alumni",
        "%s/AlumniNet",
        "%s/IT",
        "%s/Valhalla",
        "%s/New_board",
        "%s/Call",
        "%s/CE",
        "%s/Merchandise",
        "%s/Announcement",
        "%s/Misc",
        "%s/Varia",
        "%s/Extras",
        "%s/Guests",
        "%s/Coorganisers",
        "%s/Participants",
        "%s/Departments",
        "%s/RegionalAdvisers",
        "%s/Regionals",
    }

    --- Create needed folders
    for _, folder in ipairs(NEEDED_FOLDERS) do
        create_mailbox(account, string.format(folder, BEST_DIR))
    end


    ------------------------
    ---  Sort the Mails  ---
    ------------------------

    --- Projects
    result = any_recipient(account[BEST_DIR], 'LBGs-projects@best.eu.org')
    result = match_field2(account[BEST_DIR], 'Subject', '^[[]Projects[]]', result)
    result:move_messages(account[string.format("%s/Projects", BEST_DIR)])

    result = any_recipient(account[BEST_DIR], 'projects@best.eu.org')
    result:move_messages(account[string.format("%s/Projects", BEST_DIR)])

    --- New board
    result = any_recipient(account[BEST_DIR], 'LBGs@best.eu.org')
    result = match_field2(account[BEST_DIR], 'Subject', '(?i)[[]New[ ]board[]]', result)
    result:move_messages(account[string.format("%s/New_board", BEST_DIR)])

    --- Call
    result = any_recipient(account[BEST_DIR], 'LBGs@best.eu.org')
    tmp_call = match_field2(account[BEST_DIR], 'Subject', '^[[]Call[]]', result)

    tmp_jam = match_field2(account[BEST_DIR], 'Subject', '(?i)(([]]| )?jam([[]| )?|[[]jam[]])', tmp_call)
    tmp_jam:move_messages(account[string.format("%s/Participants", BEST_DIR)])

    result = tmp_call - tmp_jam
    result:move_messages(account[string.format("%s/Call", BEST_DIR)])

    --- Announcement
    result = any_recipient(account[BEST_DIR], 'LBGs@best.eu.org')
    result = match_field2(account[BEST_DIR], 'Subject', '^[[]Announcement[]]', result)
    result:move_messages(account[string.format("%s/Announcement", BEST_DIR)])

    --- Misc
    result = any_recipient(account[BEST_DIR], 'LBGs@best.eu.org')
    result = match_field2(account[BEST_DIR], 'Subject', '^[[]Misc[]]', result)
    result:move_messages(account[string.format("%s/Misc", BEST_DIR)])

    --- Merchandise
    result = any_recipient(account[BEST_DIR], 'LBGs-local@best.eu.org')
    result = match_field2(account[BEST_DIR], 'Subject', '^[[]Merchandise[]]', result)
    result:move_messages(account[string.format("%s/Merchandise", BEST_DIR)])

    --- Varia
    result = any_recipient(account[BEST_DIR], 'LBGs-local@best.eu.org')
    result = match_field2(account[BEST_DIR], 'Subject', '^[[]Varia[]]', result)
    result:move_messages(account[string.format("%s/Varia", BEST_DIR)])

    --- Cultural exchange
    result = any_recipient(account[BEST_DIR], 'LBGs-local@best.eu.org')
    result = match_field2(account[BEST_DIR], 'Subject', '^[[]CE[]]', result)
    result:move_messages(account[string.format("%s/CE", BEST_DIR)])

    --- Extras
    result = any_recipient(account[BEST_DIR], 'LBGs-local@best.eu.org')
    result = match_field2(account[BEST_DIR], 'Subject', '^[[]Extras[]]', result)
    result:move_messages(account[string.format("%s/Extras", BEST_DIR)])

    --- Guests
    result = any_recipient(account[BEST_DIR], 'LBGs-local@best.eu.org')
    result = match_field2(account[BEST_DIR], 'Subject', '^[[]Guests[]]', result)
    result:move_messages(account[string.format("%s/Guests", BEST_DIR)])

    --- Coorganisers
    result = any_recipient(account[BEST_DIR], 'LBGs-local@best.eu.org')
    result = match_field2(account[BEST_DIR], 'Subject', '^[[]Coorganisers[]]', result)
    result:move_messages(account[string.format("%s/Coorganisers", BEST_DIR)])

    --- Participants
    result = any_recipient(account[BEST_DIR], 'LBGs-local@best.eu.org')
    result = match_field2(account[BEST_DIR], 'Subject', '^[[]Participants[]]', result)
    result:move_messages(account[string.format("%s/Participants", BEST_DIR)])

    --- Departments
    result = any_recipient(account[BEST_DIR], 'departments@best.eu.org')
    result:move_messages(account[string.format("%s/Departments", BEST_DIR)])

    --- Alumni
    result = any_recipient(account[BEST_DIR], 'alumni@best.eu.org')
    result:move_messages(account[string.format("%s/Alumni", BEST_DIR)])

    --- AlumniNet
    result = any_recipient(account[BEST_DIR], 'alumninet@best.eu.org')
    result:move_messages(account[string.format("%s/AlumniNet", BEST_DIR)])

    --- IT
    result = any_recipient(account[BEST_DIR], 'it-itdept@best.eu.org') +
             any_recipient(account[BEST_DIR], 'itd@best.eu.org') + 
             any_recipient(account[BEST_DIR], 'itid@best.eu.org') + 
             any_recipient(account[BEST_DIR], 'ita@best.eu.org') + 
             any_recipient(account[BEST_DIR], 'itc@best.eu.org') + 
             any_recipient(account[BEST_DIR], 'itid@BEST.eu.org') + 
             any_recipient(account[BEST_DIR], 'itdept@best.eu.org') + 
             any_recipient(account[BEST_DIR], 'it-id@best.eu.org') + 
             any_recipient(account[BEST_DIR], 'helpdesk-members@best.eu.org') + 
             any_recipient(account[BEST_DIR], 'it-department@best.eu.org') +
             any_recipient(account[BEST_DIR], 'it-department@best-eu.org') +
             any_recipient(account[BEST_DIR], 'it-observers@best.eu.org')
    result:move_messages(account[string.format("%s/IT", BEST_DIR)])

    --- Valhalla (Region 08 - us)
    result = any_recipient(account[BEST_DIR], 'region8@best.eu.org') +
             any_recipient(account[BEST_DIR], 'region08@best.eu.org')
    result:move_messages(account[string.format("%s/Valhalla", BEST_DIR)])

    --- Regional Advisers
    result = any_recipient(account[BEST_DIR], 'regionaladvisers@best.eu.org')
    result:move_messages(account[string.format("%s/RegionalAdvisers", BEST_DIR)])

    --- Regionals
    result = any_recipient(account[BEST_DIR], 'regions@best.eu.org')
    result:move_messages(account[string.format("%s/Regionals", BEST_DIR)])


    ------------------------------
    ---  Mark folders as read  ---
    ------------------------------
    if config['mark_folders_as_read'] ~= nil then
        for _, folder in ipairs(config['mark_folders_as_read']) do
            result = account[string.format("%s/%s", BEST_DIR, folder)]:is_unseen()
            result:mark_seen()
        end
    end
end


------------------
---  Accounts  ---
------------------

require "accounts"

for i=1, #accounts do
    sorting(accounts[i]["imap"], accounts[i]["config"])
end
