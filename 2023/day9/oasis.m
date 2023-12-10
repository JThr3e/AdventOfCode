warning("off")

data = importdata('input', ' ');
width = size(data)(2);
height = size(data)(1);

x = linspace(0,width-1,width);
function fit = polyfit_auto(x, y, q)
    for i = 1:100
        [p, S] = polyfit(x,y,i);
	if S.normr < 0.00001
	    predict = polyval(p, q);
            fit = cast(predict, "int64");
	    return
	end
    end
    error("need bigger polynomial!!");
end

total = 0;
for i = 1:height
    row = data(i, :);
    p_int = polyfit_auto(x, row, width);
    total = total + p_int;
end

disp(total)
