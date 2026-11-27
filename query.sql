SELECT
    r.route_no,
    r.departure_airport,
    r.arrival_airport,
    a.airport_name->>'ru' AS departure_airport_name,
    to_char(
        f.actual_arrival AT TIME ZONE 'UTC',
        'YYYY-MM-DD HH24:MI:SS.US'
    ) || '+00' AS actual_arrival
FROM routes AS r
JOIN airports_data AS a
    ON a.airport_code = r.departure_airport
JOIN flights AS f
    ON f.route_no = r.route_no
WHERE f.status = 'Arrived'
ORDER BY f.actual_arrival DESC
LIMIT 20;
