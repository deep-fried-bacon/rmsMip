tempMap = containers.Map();
tempMap('a') = 'aaa';
tempMap('b') = 'bbb';



try 
    exper('butt')
    %t = tempMap('c');
    %num2string('ss')
catch e
    disp(e.stack)
    %disp(e.msgID)
    %disp(e.identifier)
    %disp(e.message)
    %disp(e.cause)
    %disp(e.stack)
    %disp(dbstack)
end
    