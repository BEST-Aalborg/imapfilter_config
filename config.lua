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

function sorting(account)

    --- Create needed folders
    create_mailbox(account, 'BEST')
    create_mailbox(account, 'BEST/Alumni')
    create_mailbox(account, 'BEST/AlumniNet')
    create_mailbox(account, 'BEST/IT')
    create_mailbox(account, 'BEST/Valhalla')

    create_mailbox(account, 'BEST/Projects')
    create_mailbox(account, 'BEST/New_board')
    create_mailbox(account, 'BEST/Call')
    create_mailbox(account, 'BEST/CE')
    create_mailbox(account, 'BEST/Merchandise')
    create_mailbox(account, 'BEST/Announcement')
    create_mailbox(account, 'BEST/Misc')
    create_mailbox(account, 'BEST/Varia')

    create_mailbox(account, 'BEST/Extras')
    create_mailbox(account, 'BEST/Guests')
    create_mailbox(account, 'BEST/Coorganisers')
    create_mailbox(account, 'BEST/Participants')
    create_mailbox(account, 'BEST/Departments')

    ------------------------
    ---  Sort the Mails  ---
    ------------------------

    --- Alumni
    result = any_recipient(account.BEST, 'alumni@best.eu.org')
    result:move_messages(account["BEST/Alumni"])

    --- AlumniNet
    result = any_recipient(account.BEST, 'alumninet@best.eu.org')
    result:move_messages(account["BEST/AlumniNet"])

    --- IT
    result = any_recipient(account.BEST, 'it-itdept@best.eu.org') +
            any_recipient(account.BEST, 'itd@best.eu.org') + 
            any_recipient(account.BEST, 'itid@best.eu.org') + 
            any_recipient(account.BEST, 'ita@best.eu.org') + 
            any_recipient(account.BEST, 'itc@best.eu.org') + 
            any_recipient(account.BEST, 'itid@BEST.eu.org') + 
            any_recipient(account.BEST, 'itdept@best.eu.org') + 
            any_recipient(account.BEST, 'helpdesk-members@best.eu.org') + 
            any_recipient(account.BEST, 'it-department@best.eu.org')
    result:move_messages(account["BEST/IT"])

    --- Valhalla (Region 08 - us)
    result = any_recipient(account.BEST, 'region8@best.eu.org')
    result:move_messages(account["BEST/Valhalla"])

    --- Projects
    result = any_recipient(account.BEST, 'LBGs-projects@best.eu.org')
    result = match_field2(account["BEST"], 'Subject', '^[[]Projects[]]', result)
    result:move_messages(account["BEST/Projects"])

    result = any_recipient(account.BEST, 'projects@best.eu.org')
    result:move_messages(account["BEST/Projects"])

    --- New board
    result = any_recipient(account.BEST, 'LBGs@best.eu.org')
    result = match_field2(account["BEST"], 'Subject', '(?i)[[]New[ ]board[]]', result)
    result:move_messages(account["BEST/New_board"])

    --- Call
    result = any_recipient(account.BEST, 'LBGs@best.eu.org')
    tmp_call = match_field2(account["BEST"], 'Subject', '^[[]Call[]]', result)

    tmp_jam = match_field2(account["BEST"], 'Subject', '(?i)(([]]| )?jam([[]| )?|[[]jam[]])', tmp_call)
    tmp_jam:move_messages(account["BEST/Participants"])

    result = tmp_call - tmp_jam
    result:move_messages(account["BEST/Call"])

    --- Announcement
    result = any_recipient(account.BEST, 'LBGs@best.eu.org')
    result = match_field2(account["BEST"], 'Subject', '^[[]Announcement[]]', result)
    result:move_messages(account["BEST/Announcement"])

    --- Misc
    result = any_recipient(account.BEST, 'LBGs@best.eu.org')
    result = match_field2(account["BEST"], 'Subject', '^[[]Misc[]]', result)
    result:move_messages(account["BEST/Misc"])

    --- Merchandise
    result = any_recipient(account.BEST, 'LBGs-local@best.eu.org')
    result = match_field2(account["BEST"], 'Subject', '^[[]Merchandise[]]', result)
    result:move_messages(account["BEST/Merchandise"])

    --- Varia
    result = any_recipient(account.BEST, 'LBGs-local@best.eu.org')
    result = match_field2(account["BEST"], 'Subject', '^[[]Varia[]]', result)
    result:move_messages(account["BEST/Varia"])

    --- Cultural exchange
    result = any_recipient(account.BEST, 'LBGs-local@best.eu.org')
    result = match_field2(account["BEST"], 'Subject', '^[[]CE[]]', result)
    result:move_messages(account["BEST/CE"])

    --- Extras
    result = any_recipient(account["BEST"], 'LBGs-local@best.eu.org')
    result = match_field2(account["BEST"], 'Subject', '^[[]Extras[]]', result)
    result:move_messages(account["BEST/Extras"])

    --- Guests
    result = any_recipient(account.BEST, 'LBGs-local@best.eu.org')
    result = match_field2(account["BEST"], 'Subject', '^[[]Guests[]]', result)
    result:move_messages(account["BEST/Guests"])

    --- Coorganisers
    result = any_recipient(account.BEST, 'LBGs-local@best.eu.org')
    result = match_field2(account["BEST"], 'Subject', '^[[]Coorganisers[]]', result)
    result:move_messages(account["BEST/Coorganisers"])

    --- Participants
    result = any_recipient(account.BEST, 'LBGs-local@best.eu.org')
    result = match_field2(account["BEST"], 'Subject', '^[[]Participants[]]', result)
    result:move_messages(account["BEST/Participants"])

    --- Departments
    result = any_recipient(account.BEST, 'departments@best.eu.org')
    result:move_messages(account["BEST/Departments"])
end


------------------
---  Accounts  ---
------------------

require "accounts"

for i=1, #accounts do
    print(i)
    sorting(accounts[i])
end
