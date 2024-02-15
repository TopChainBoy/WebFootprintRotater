# WebFrootprintRotater - Web Privacy Enhancement Script

This script is designed to enhance your web privacy by clearing cookies and changing the user agent in Mozilla Firefox and Google Chrome.

## Getting Started

These instructions will get you a copy of the project up and running on your local machine for development and testing purposes.

### Prerequisites

You need to have `bash` and `sqlite3` installed on your system to run this script. If not installed, you can install them using the following commands:

```
sudo apt-get install bash
sudo apt-get install sqlite3
```

### Installing

Clone the repository to your local machine:

```
git clone https://github.com/TopChainBoy/WebFrootprintRotater.git
```

Navigate to the project directory:

```
cd WebFrootprintRotater
```
Make the script executable:

```
chmod +x webFrootprintRotater.sh
```

### Usage

The script can be run with the following command:

```
./webFrootprintRotater.sh
```

The script will check if Mozilla Firefox and Google Chrome directories exist in your system. If they do, it will clear cookies and change the user agent for these browsers.

## Built With

- Bash: The GNU Project's shell
- SQLite: A C library that provides a lightweight disk-based database

## Authors

* **TopChainBoy** - *Initial work* - [TopChainBoy](https://github.com/TopChainBoy)

## License

This project is licensed under the MIT License - see the [LICENSE.md](LICENSE.md) file for details

## Acknowledgements

This script uses the Bash shell and SQLite. We would like to acknowledge and thank the creators of these tools:

- `bash`: Brian Fox and Chet Ramey, first released in 1989
- `SQLite`: D. Richard Hipp, first released in 2000

Please note that this date is for the first release of the tool and it may have been updated or maintained by different individuals or groups since then.
