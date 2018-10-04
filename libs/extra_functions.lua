-------------------
---  Functions  ---
-------------------

function mime_decoder(data)
    status, encode = pipe_from('~/.imapfilter/mime_decoder.py ' .. enc(data))
    return encode
end

function match_field2(self, field, pattern)
    _check_required(field, 'string')
    _check_required(pattern, 'string')

    local set = Set()
    for mbox in pairs(_extract_mailboxes(self)) do
        print(mbox)
        set = set + mbox.match_field2(mbox, field, pattern, self)
    end
    return self * set
end

function match_field2(self, field, pattern, messages)
    _check_required(field, 'string')
    _check_required(pattern, 'string')

    if not messages then messages = self._send_query(self) end
    local mesgs = _extract_messages(self, messages)
    local fields = self._fetch_fields(self, { field }, mesgs)
    if #mesgs == 0 or fields == nil then return Set({}) end
    local results = {}
    for m, f in pairs(fields) do
         print("---" .. m .. "---")
         print(f)
        f = mime_decoder(f)
         print(f)
        re = string.gsub(f, '^[^: ]*: ?(.*)$', '%1')
         print(re)
        
        if regex_search(pattern, (re)) then
            table.insert(results, {self, m})
        end
        print("")
    end

    return Set(results)
end

function any_recipient(mailbox, email)
    return mailbox:is_unseen() *
           ( mailbox:contain_to(email) + 
             mailbox:contain_cc(email) + 
             mailbox:contain_bcc(email) )
end

function create_mailbox(acc, mailbox)
    if string.sub(mailbox, string.len(mailbox), -1) == "/" then
        mailbox = string.sub(mailbox, 0, -2)
    end

    for i = string.len(mailbox),1,-1 do
        if string.sub(mailbox, i, i) == '/' then
            tmp = string.sub(mailbox, 0, i-1)
            folders = acc:list_all(tmp, folder)
            
            create = 1
            for _, f in ipairs(folders) do 
                if f == mailbox then
                    create = 0
                end
            end
            if create == 1 then
                acc:create_mailbox(mailbox)
                break
            end
        end
    end
end

local base64enc='ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/'
function enc(data)
    return ((data:gsub('.', function(x) 
        local r,base64enc='',x:byte()
        for i=8,1,-1 do r=r..(base64enc%2^i-base64enc%2^(i-1)>0 and '1' or '0') end
        return r;
    end)..'0000'):gsub('%d%d%d?%d?%d?%d?', function(x)
        if (#x < 6) then return '' end
        local c=0
        for i=1,6 do c=c+(x:sub(i,i)=='1' and 2^(6-i) or 0) end
        return base64enc:sub(c+1,c+1)
    end)..({ '', '==', '=' })[#data%3+1])
end 
