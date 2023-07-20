import csv
from datetime import date
import io
from typing import List


# avoiding pandas
def generate_csv(sqlalchemy_query: List, headers: List[str], report_date: date):
    output = io.StringIO()
    writer = csv.writer(output)

    file_headers = headers.copy()
    file_headers.append("report_pull_date")
    writer.writerow(file_headers)

    for row in sqlalchemy_query:
        data_row = [getattr(row, column) for column in headers]
        data_row.append(report_date)
        writer.writerow(data_row)

    return output.getvalue()
