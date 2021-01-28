import zipfile

import requests
import os
import tempfile


def download_pums_data(year, record_type, state):
    assert record_type in ('person', 'housing')

    output_dir = get_pums_data_dir(year, record_type, state)

    if os.path.exists(output_dir):
        return

    download_url = f"https://www2.census.gov/programs-surveys/acs/data/pums/{year}/1-Year/csv_{record_type[0]}{state}.zip"
    with tempfile.TemporaryDirectory() as temp_download_dir:
        temp_download_path = os.path.join(temp_download_dir, "temp.zip")
        with open(temp_download_path, 'wb') as resource_file:
            resource_file.write(requests.get(download_url).content)

        os.makedirs(output_dir, exist_ok=True)
        with zipfile.ZipFile(temp_download_path, 'r') as zip_file:
            [zip_file.extract(file, output_dir) for file in zip_file.namelist()]


def get_pums_data_dir(year, record_type, state):
    base_dir = os.path.join(os.path.dirname(os.path.realpath(__file__)), '..', 'data')
    return os.path.join(base_dir, f'PUMS_{year}_{record_type}_{state}')


def get_pums_data_path(year, record_type, state):
    """returns path to the first .csv file"""
    data_dir = get_pums_data_dir(year, record_type, state)
    for file_name in os.listdir(data_dir):
        if file_name.endswith('.csv'):
            return os.path.join(data_dir, file_name)


datasets = [
    {'year': 2010, 'record_type': 'person', 'state': 'ma'},
    {'year': 2011, 'record_type': 'person', 'state': 'ma'},
    {'year': 2011, 'record_type': 'person', 'state': 'tx'},
]

if __name__ == '__main__':

    for metadata in datasets:
        print("downloading", metadata)

        print(get_pums_data_dir(**metadata))
        download_pums_data(**metadata)