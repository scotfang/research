%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%% Fmain_parsesequence.m
%%%%% given an video sequence, output the tree structure of parsing
%%%%% INPUT:
%%%%% Xm: 20*N matrix, human skeleton and motion data, each column is a
%%%%%     frame
%%%%% Ym: 1*N cell matrix, the frame name 
%%%%% Grammar: grammar rules
%%%%% OUTPUT:
%%%%% treelist: several tree structure of video parsing

function parsetrees = Fmain_parsesequence(Xm,Ym,Grammar,Maxpts)
%%%%% struct definition
% tree = struct('root',{},'atom',{},'index',{},'frameindex',{},'energy',{});
% parsetrees = struct('trees',{},'segments',{},'framesegs',{},'tenergy',{});
%%%%% Initialize variables
[D,T] = size(Xm);
Ng = size(Grammar,2);



%%%%% Initialize parse trees
atom_prb = Fatom_prb(Xm(:,1),Grammar);
for i = 1:Ng
    grammar = Grammar(i);
    tree.root = grammar.event;
    tree.atom{1} = grammar.atom;
    tree.index(1,1) = 1;
    tree.index(1,2) = 1;
    frmindex = Fframe_index(Ym{1});
    tree.frameindex(1,1) = frmindex;
    tree.frameindex(1,2) = frmindex;
    tree.energy = -log(atom_prb(i));
    parsetrees(i).trees(1) = tree;
    parsetrees(i).segments(1,1) = 1;
    parsetrees(i).segments(1,2) = 1;
    parsetrees(i).framesegs(1,1) = frmindex;
    parsetrees(i).framesegs(1,2) = frmindex;
    parsetrees(i).tenergy = tree.energy;
end

for t = 2:T
    atom_prb = Fatom_prb(Xm(:,t),Grammar);
    Np = size(parsetrees,2); %%%%% number of current parse trees list
    Ntp = 0; %%%%% number of temporal parse trees list
    clear tparsetrees pts last_tree
    for pi = 1:Np
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        %%%%% repeat atomic event
        pts = parsetrees(pi);
        last_tree = pts.trees(end);
        last_atom = last_tree.atom(end);
        grm = FatomINGrammar(last_atom,Grammar);
        elkh = -log(atom_prb(grm.index)); %%%%% energy of likelihood
        tuple = last_tree.index(end,2) - last_tree.index(end,1) + 1;
        etrs = FTransEnergy(grm,tuple,0);
        last_tree.index(end,2) = t;
        frmindex = Fframe_index(Ym{t});
        last_tree.frameindex(end,2) = frmindex;
        last_tree.energy = last_tree.energy + elkh + etrs;
        pts.trees(end) = last_tree;
        pts.segments(end,2) = t;
        pts.framesegs(end,2) = frmindex;
        pts.tenergy = pts.tenergy + elkh + etrs;
        Ntp = Ntp + 1;
        tparsetrees(Ntp) = pts;
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        %%%%% next atomic event
        pts = parsetrees(pi);
        last_tree = pts.trees(end);
        last_atom = last_tree.atom(end);
        grm = FatomINGrammar(last_atom,Grammar);
        if ~isempty(grm.next)
            elkh = -log(atom_prb(grm.index+1)); %%%%% energy of likelihood
            tuple = last_tree.index(end,2) - last_tree.index(end,1) + 1;
            etrs = FTransEnergy(grm,tuple,1);
            last_tree.atom{end+1} = grm.next;
            last_tree.index((end+1),1) = t;
            last_tree.index((end),2) = t;
            frmindex = Fframe_index(Ym{t});
            last_tree.frameindex((end+1),1) = frmindex;
            last_tree.frameindex((end),2) = frmindex;
            last_tree.energy = last_tree.energy + elkh + etrs;
            pts.trees(end) = last_tree;
            pts.segments(end,2) = t;
            pts.framesegs(end,2) = frmindex;
            pts.tenergy = pts.tenergy + elkh + etrs;
            Ntp = Ntp + 1;
            tparsetrees(Ntp) = pts;
        end
    end
    if size(tparsetrees,2)<= Maxpts
        parsetrees = tparsetrees;
    else
        E = [tparsetrees.tenergy];
        [~,Ind] = sort(E);
        parsetrees = tparsetrees(Ind(1:Maxpts));
    end   
end

































