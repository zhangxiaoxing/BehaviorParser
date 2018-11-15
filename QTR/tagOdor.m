function out=tagOdor(data)
    bj=[32 33 700 701 702 703 704 707 101 102 103 105 106 107 108 109];
    mk=[37 38 40 41 64 65 66 67];
    rq=[76 77 78 79 80 81 82 83];

%     pos=[33 38 41 101 102 106 107 66 67 76 78 80 81 83];

    for i=1:size(data,1)
        if ismember(cell2mat(data(i,1)),bj)
            data{i,8}='BJ';
        elseif ismember(cell2mat(data(i,1)),mk)
            data{i,8}='MK';
        elseif ismember(cell2mat(data(i,1)),rq)
            data{i,8}='RQ';
        end
    end
    out=data;
end