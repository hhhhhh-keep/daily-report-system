package com.company.daily.masterdata.state;

import java.util.Set;

public class ProjectStateResolver {
  private static final Set<String> PRESALES = Set.of(
      "requirements-analysis", "solution-design", "bid-quotation", "technical-presentation",
      "presales-requirements-analysis", "presales-solution-design", "presales-bid-quotation",
      "presales-technical-presentation");
  private static final Set<String> DELIVERY = Set.of(
      "implementation", "testing-deployment", "training-acceptance",
      "delivery-implementation", "delivery-testing-deployment", "delivery-training-acceptance");
  private static final Set<String> AFTERSALES = Set.of(
      "operations-support", "incident-handling", "optimization-upgrade", "customer-support",
      "after-sales-operations-support", "after-sales-incident-handling",
      "after-sales-optimization-upgrade", "after-sales-customer-support");

  public ProjectDerivedStateValue resolve(ProjectStateFact fact) {
    if ("blocked".equals(fact.currentStatus())) {
      return ProjectDerivedStateValue.BLOCKED;
    }
    if ("paused".equals(fact.currentStatus())) {
      return ProjectDerivedStateValue.PAUSED;
    }
    if ("special-work".equals(fact.workType())) {
      return ProjectDerivedStateValue.IN_PROGRESS;
    }
    if (fact.workStage() == null) {
      return ProjectDerivedStateValue.IN_PROGRESS;
    }
    if (PRESALES.contains(fact.workStage())) {
      return ProjectDerivedStateValue.PRESALES_IN_PROGRESS;
    }
    if (DELIVERY.contains(fact.workStage())) {
      return ProjectDerivedStateValue.DELIVERY_IN_PROGRESS;
    }
    if (AFTERSALES.contains(fact.workStage())) {
      return ProjectDerivedStateValue.AFTERSALES_IN_PROGRESS;
    }
    return ProjectDerivedStateValue.IN_PROGRESS;
  }
}
