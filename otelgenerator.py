import json
import random
import uuid
from opentelemetry.sdk.metrics import MeterProvider, Counter
from opentelemetry.sdk.metrics.export import PeriodicExportingMetricReader
from opentelemetry.exporter.otlp.proto.grpc.metric_exporter import OTLPMetricExporter
from opentelemetry.metrics import get_meter_provider, set_meter_provider,
get_meter
import logging
logging.basicConfig(
format="%(asctime)s %(levelname)-8s %(message)s", level=logging.NOTSET, datefmt="%Y-%m-%d %H:%M:%S",)

logger = logging.getLogger(__name__)
logger.setLevel(logging.DEBUG)
# uuid
container_id = uuid.uuid4().hex
logger.debug(container_id)
logger.debug("Setup")

exporter = OTLPMetricExporter(endpoint="http://k8s-awsotele-metricscxxxxxxxxxx-xxxxxxxxxxxxxxxx.elb.ap-southeast-2.amazonaws.com:4317")
reader = PeriodicExportingMetricReader(exporter, export_interval_millis=10)
provider = MeterProvider(metric_readers=[reader])
set_meter_provider(provider)
meter = get_meter("lamba_meter")
metric_interval_counter = meter.create_counter("interval.counter", unit="1",
description="Counts the number of intervals processed")

def lambda_handler(event, context):
    logger.debug("Adding count to interval.counter")
    for i in range(200):
        metric_interval_counter.add(random.randint(1, 288), {"job": __name__, "type": "IntervalCounter","hes":random.choice(["EDMI", "CC", "PNET"])})
        provider.force_flush(100)
    return {
        "statusCode": 200,
        "body": json.dumps({
        "message": "Metrics Recorded",
        }),
    }