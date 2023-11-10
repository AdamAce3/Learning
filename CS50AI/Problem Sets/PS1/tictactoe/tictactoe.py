"""
Tic Tac Toe Player
"""

import math
import copy

X = "X"
O = "O"
EMPTY = None


def initial_state():
    """
    Returns starting state of the board.
    """
    return [[EMPTY, EMPTY, EMPTY],
            [EMPTY, EMPTY, EMPTY],
            [EMPTY, EMPTY, EMPTY]]


def player(board):
    """
    Returns player who has the next turn on a board.
    """
    num_X = 0
    num_O = 0
    for row in range(3):
        num_X += board[row].count(X)
        num_O += board[row].count(O)
    if num_X == num_O:
        return X
    else:
        return O


def actions(board):
    """
    Returns set of all possible actions (i, j) available on the board.
    """
    possible_actions = set()
    for i in range(3):
        for j in range(3):
            if board[i][j] == EMPTY:
                possible_actions.add((i,j))
    return possible_actions


def result(board, action):
    """
    Returns the board that results from making move (i, j) on the board.
    """
    if board[action[0]][action[1]] != EMPTY:
        raise Exception("Invalid Action.")
    else:
        new_board = copy.deepcopy(board)
        new_board[action[0]][action[1]] = player(board)
        return new_board


def winner(board):
    """
    Returns the winner of the game, if there is one.
    """
    # Check rows
    for row in board:
        if row[0] == row[1] == row[2]:
            return row[0]
    # Check columns
    for column in range(3):
        if board[0][column] == board[1][column] == board[2][column]:
            return board[0][column]
    # Check diaganols
    if board[0][0] == board[1][1] == board[2][2]:
        return board[1][1]
    elif board[0][2] == board[1][1] == board[2][0]:
        return board[1][1]
    return None
    


def terminal(board):
    """
    Returns True if game is over, False otherwise.
    """
    if winner(board) in [X, O]: #checks if theres a winner = game over
        return True
    elif winner(board) == None and any(EMPTY in row for row in board): #checks if game is in progress
        return False
    else:
        return True


def utility(board):
    """
    Returns 1 if X has won the game, -1 if O has won, 0 otherwise.
    """
    if winner(board) == X:
        return 1
    elif winner(board) == O:
        return -1
    else:
        return 0


def minimax(board):
    """
    Returns the optimal action for the current player on the board.
    """
    if terminal(board):
        return None
    moves = []
    if player(board) == X: #max player
        for action in actions(board):
            moves.append((min_value(result(board, action)), action))
        return sorted(moves, key = lambda x: x[0], reverse = True)[0][1]
    elif player(board) == O: #min player
        for action in actions(board):
            moves.append((max_value(result(board, action)), action))
        return sorted(moves, key = lambda x: x[0])[0][1]
        
def min_value(board):
    v = math.inf
    if terminal(board):
        return utility(board)
    for action in actions(board):
        v = min(v, max_value(result(board, action)))
    return v

def max_value(board):
    v = -math.inf
    if terminal(board):
        return utility(board)
    for action in actions(board):
        v = max(v, min_value(result(board, action)))
    return v