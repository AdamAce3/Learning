import pytest
from tictactoe import initial_state, player, actions, result, winner, terminal, utility, minimax

X = "X"
O = "O"
EMPTY = None

def test_initial_state():
    assert initial_state() == [[EMPTY, EMPTY, EMPTY],
                                [EMPTY, EMPTY, EMPTY],
                                [EMPTY, EMPTY, EMPTY]]
    
def test_player():
    assert player([[EMPTY, X, EMPTY],
                    [EMPTY, EMPTY, EMPTY],
                    [EMPTY, EMPTY, EMPTY]]) == O
    assert player([[EMPTY, EMPTY, EMPTY],
                    [EMPTY, X, EMPTY],
                    [EMPTY, EMPTY, EMPTY]]) == O
    assert player([[EMPTY, X, EMPTY],
                    [EMPTY, O, EMPTY],
                    [EMPTY, EMPTY, EMPTY]]) == X
    assert player([[EMPTY, X, EMPTY],
                    [X, O, O],
                    [EMPTY, X, O]]) == X
    
def test_actions():
    assert actions([[EMPTY, EMPTY, EMPTY],
                    [EMPTY, EMPTY, EMPTY],
                    [EMPTY, EMPTY, EMPTY]]) == {(0,0),(0,1),(0,2),(1,0),(1,1),(1,2),(2,0),(2,1),(2,2)}
    assert actions([[X, EMPTY, EMPTY],
                    [EMPTY, EMPTY, EMPTY],
                    [EMPTY, EMPTY, EMPTY]]) == {(0,1),(0,2),(1,0),(1,1),(1,2),(2,0),(2,1),(2,2)}
    assert actions([[X, EMPTY, EMPTY],
                    [EMPTY, O, EMPTY],
                    [EMPTY, EMPTY, X]]) == {(0,1),(0,2),(1,0),(1,2),(2,0),(2,1)}
    assert actions([[X, O, X],
                    [O, X, O],
                    [X, O, X]]) == set() #empty set
    
def test_result():
    assert result([[EMPTY, EMPTY, EMPTY],
                    [EMPTY, EMPTY, EMPTY],
                    [EMPTY, EMPTY, EMPTY]], (0,0)) == [[X, EMPTY, EMPTY],
                                                        [EMPTY, EMPTY, EMPTY],
                                                        [EMPTY, EMPTY, EMPTY]]
    assert result([[EMPTY, EMPTY, EMPTY],
                    [EMPTY, EMPTY, EMPTY],
                    [EMPTY, EMPTY, EMPTY]], (1,1)) == [[EMPTY, EMPTY, EMPTY],
                                                        [EMPTY, X, EMPTY],
                                                        [EMPTY, EMPTY, EMPTY]]
    assert result([[X, EMPTY, EMPTY],
                    [EMPTY, EMPTY, EMPTY],
                    [EMPTY, EMPTY, EMPTY]], (1,1)) == [[X, EMPTY, EMPTY],
                                                        [EMPTY, O, EMPTY],
                                                        [EMPTY, EMPTY, EMPTY]]

def test_winner():
    assert winner([[X, X, X],
                    [O, X, O],
                    [O, EMPTY, EMPTY]]) == X
    assert winner([[X, X, O],
                    [O, O, O],
                    [X, X, EMPTY]]) == O
    assert winner([[X, EMPTY, X],
                    [O, X, O],
                    [O, EMPTY, X]]) == X
    assert winner([[X, X, O],
                    [O, O, O],
                    [O, X, X]]) == O
    assert winner([[X, O, X],
                    [X, O, X],
                    [O, X, O]]) == None

def test_terminal():
    assert terminal([[X, X, X],
                [O, X, O],
                [O, EMPTY, EMPTY]]) == True
    assert terminal([[X, X, O],
                    [O, O, O],
                    [X, X, EMPTY]]) == True
    assert terminal([[X, O, X],
                    [X, O, X],
                    [O, X, O]]) == True
    assert terminal([[X, O, X],
                    [X, EMPTY, X],
                    [O, X, O]]) == False

def test_utility():
    assert utility([[X, X, X],
                    [O, X, O],
                    [O, EMPTY, EMPTY]]) == 1
    assert utility([[X, X, O],
                    [O, O, O],
                    [X, X, EMPTY]]) == -1
    assert utility([[X, EMPTY, X],
                    [O, X, O],
                    [O, EMPTY, X]]) == 1
    assert utility([[X, X, O],
                    [O, O, O],
                    [O, X, X]]) == -1
    assert utility([[X, O, X],
                    [X, O, X],
                    [O, X, O]]) == 0
