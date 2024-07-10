local IOF = {}

function IOF.signals(delay)
        delay = delay or 0.05
        string = "=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-="
        for i = 1, #string, 1 do
                io.write(string.sub(string, i, i))
                io.flush()
                os.execute("sleep " .. tonumber(delay))
        end
        print()
end

function IOF.betweenSignals(string, delay)
        delay = delay or 0.05
        IOF.signals(delay)
        IOF.dramaticWriting(string, delay, 1)
        IOF.signals(delay / 2)
end

function IOF.dramaticWriting(string, delay, breakline)
        delay = delay or 0.05
        breakline = breakline or 0
        for i = 1, #string, 1 do
                if string.sub(string, i, i) == '\\' then
                    i = i + 1
                end
                io.write(string.sub(string, i, i))
                io.flush()
                os.execute("sleep " .. tonumber(delay))
        end
        if breakline == 1 then
            print()
        end
end

return IOF