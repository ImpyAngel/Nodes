# examle making script 
# python3 exampleScript.py -m Hi

import argparse

parser = argparse.ArgumentParser(description="Description")

parser.add_argument('-m', '--message', help='Message for write', required=True, type=str, metavar='TEXTSTRING')
args = parser.parse_args()


def main(message):
    print(message)


if __name__ == '__main__':
    main(args.message)