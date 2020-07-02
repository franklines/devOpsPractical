#!/bin/bash
# Author: Franklin E.
# Description: Bash script to deploy swimlane app and also destroy.

set -u 

function deleteAll()
{
    echo "Deleting services...";
    kubectl delete svc swimlane-app mongodb;
    echo "Deleting deployments...";
    kubectl delete deployment swimlane-app-deployment;
    kubectl delete statefulset mongodb-deployment;
    echo "Nuking all PVs & PVCS!!!";
    kubectl delete pvc --all;
    kubectl delete pv --all;
    echo "Deleting secrets...";
    kubectl delete secret swimlane-app-secrets mongodb-secrets;
    echo "All set!"
}

function deployAll()
{
    for sc in `ls storage/`;
    do
        kubectl apply -f storage/${sc};
    done

    for sec in `ls secrets/`;
    do
        kubectl apply -f secrets/${sec};
    done

    for svc in `ls services/`;
    do
        kubectl apply -f services/${svc};
    done

    # MongoDB first. :)
    echo "Launching MongoDB pod via deployment - ETA ~ 5 mins...";
    kubectl apply -f deployments/mongodb-deployment.yaml;
    echo "Sleeping for 10 mins.... (so pod can ready up)";
    sleep 600;
    echo "Launching Swimlane App pod via deployment....";
    kubectl apply -f deployments/swimlane-app-deployment.yaml;

}

while getopts "dr" opt; do
  case ${opt} in
    d )
        deployAll
        ;;
    r )
        deleteAll
        ;;
    \? )
        echo "Invalid option: $OPTARG" 1>&2
        ;;
    : )
        echo "Invalid option: $OPTARG requires an argument" 1>&2
        ;;
  esac
done
shift $((OPTIND -1))